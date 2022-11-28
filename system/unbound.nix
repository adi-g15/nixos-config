# @ref: https://libreddit.tiekoetter.com/r/NixOS/comments/innzkw/pihole_style_adblock_with_nix_and_unbound/

{ pkgs, ... }:

let

  adblockLocalZones = pkgs.stdenv.mkDerivation {
    name = "unbound-zones-adblock";

    src = (pkgs.fetchFromGitHub {
      owner = "StevenBlack";
      repo = "hosts";
      rev = "3.0.0";
      sha256 = "01g6pc9s1ah2w1cbf6bvi424762hkbpbgja9585a0w99cq0n6bxv";
    } + "/alternates/fakenews-gambling-porn/hosts");

    phases = [ "installPhase" ];

    installPhase = ''
      ${pkgs.gawk}/bin/awk '{sub(/r$/,"")} {sub(/^127.0.0.1/,"0.0.0.0")} BEGIN { OFS = "" } NF == 2 && $1 == "0.0.0.0" { print "local-zone: ", $2, " static"}' $src | tr '[:upper:]' '[:lower:]' | sort -u >  $out
    '';

  };


in {

  networking.firewall.allowedUDPPorts = [ 53 ];
  networking.firewall.allowedTCPPorts = [ 53 ];

  services.unbound = {
    enable = true;
    settings = {
      forward-zone = [{
	name = ".";
        forward-addr = [ "1.0.0.1@853#cloudflare-dns.com" "1.1.1.1@853#cloudflare-dns.com" ];
      }];
      server = {
	access-control = [ "127.0.0.0/24 allow" "192.168.0.0/24 allow" ]; # update for your LAN config
      	so-reuseport = true;
      	tls-cert-bundle = "/etc/ssl/certs/ca-certificates.crt";
      	tls-upstream = true;
	include = "${adblockLocalZones}";
      };
    };
  };
}

# ex: shiftwidth=2 expandtab:
