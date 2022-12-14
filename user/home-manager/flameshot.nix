{ ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.adityag = { config, pkgs, ... }: {
    services.flameshot.enable = true;
    services.flameshot.settings = {
      General = {
        contrastOpacity = 188;
        drawColor = "#ff0000";
        drawFontSize = 8;
        drawThickness = 1;
        ignoreUpdateToVersion = "0.10.0";
        saveAsFileExtension = "png";
        startupLaunch = true;
        uploadHistoryMax = 18;
        uploadWithoutConfirmation = true;
        disabledTrayIcon = false;
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
