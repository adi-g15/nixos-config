{ ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.adityag = { config, pkgs, ... }: {
    services.flameshot.enable = true;
    services.flameshot.settings = {
      General = {
        disabledTrayIcon = true;
        showStartupLaunchMessage = false;
        checkForUpdates = false;
        copyPathAfterSave = true;
        savePath = "/home/adityag/Pictures/Screenshots";
        savePathFixed = true;
      };
    };
   };
}

# ex: shiftwidth=2 expandtab:
