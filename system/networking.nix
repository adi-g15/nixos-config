{ pkgs, config, ... }:

{
  networking.firewall.enable = false;
  #networking.firewall = {
  #  enable = true;
  #  allowedTCPPorts = [ 80 443 3000 ];
  #};

  networking.hostName = "adityag409da"; # Define your hostname.

  # networking.nameservers = [
  #  # "2a0d:2a00:1::1"  # adult-filter-dns.cleanbrowsing.org, ipv6
  #  "2606:4700:4700::1111"  # cloudflare ipv6
  #  "1.1.1.1"  # cloudflare ipv4
  # ];

  networking.networkmanager = {
    enable = true;
    firewallBackend = "nftables";

    # TODO: networkmanager still sets plugins installing unnecessary deps (see with nix-tree), use overlays or something to modify that
    plugins = [];

    wifi = {
      backend = "iwd";
      macAddress = "random";
      # powersave = true;
    };
  };

  # @adi-g15 nftables naya wala h, usko enable krke firewall disable krna hoga
  networking.nftables.enable = true;

  networking.wireless.iwd = {
    enable = true;
    settings = {
      Network = { EnableIPv6 = true; };
      Settings = { AutoConnect = true; };
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
