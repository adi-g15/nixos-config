{ pkgs, config, ... }:

{
  networking.firewall.enable = false;

  networking.hostName = "adityag409da"; # Define your hostname.

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
