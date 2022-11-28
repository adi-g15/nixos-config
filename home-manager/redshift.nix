{ ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.adityag = { config, pkgs, ... }: {
    services.redshift = {
      enable = true;
      dawnTime = "6:00-7:45";
      duskTime = "18:35-20:15";
      latitude = 25.619288;
      longitude = 85.17697;
      provider = "manual";      # fix karde rha hu location, geoclue2 increases boot time by ~300ms
      tray = true;
    };
  };
}
      
# ex: shiftwidth=2 expandtab:

