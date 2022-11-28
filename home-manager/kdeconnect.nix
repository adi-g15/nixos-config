{ ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.adityag = { config, pkgs, ... }: {
    services.kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}

# ex: shiftwidth=2 expandtab: 
