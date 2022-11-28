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
    } + "/alternates/fakenews-porn/hosts");

    phases = [ "installPhase" ];

    installPhase = ''
      ${pkgs.gawk}/bin/awk '{sub(/r$/,"")} {sub(/^127.0.0.1/,"0.0.0.0")} BEGIN { OFS = "" } NF == 2 && $1 == "0.0.0.0" { print "local-zone: "", $2, "" static"}' $src | tr '[:upper:]' '[:lower:]' | sort -u >  $out
    '';

  };


in {

  networking.firewall.allowedUDPPorts = [ 53 ];
  networking.firewall.allowedTCPPorts = [ 53 ];

  services.unbound = {
    enable = true;
    #allowedAccess = [ "127.0.0.0/24" "192.168.0.0/24" ]; # update for your LAN config
    interfaces = [ "0.0.0.0" ];
    forwardAddresses =
      [ "1.0.0.1@853#cloudflare-dns.com" "1.1.1.1@853#cloudflare-dns.com" ];
    extraConfig = ''
        so-reuseport: yes
        tls-cert-bundle: /etc/ssl/certs/ca-certificates.crt
        tls-upstream: yes

      include: "${adblockLocalZones}"
        '';
  };

}
