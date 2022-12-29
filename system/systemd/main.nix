{ config, pkgs, ... }:

{
  imports = [
    ./batteryChargeThreshold.service.nix
  ];

  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  # @ref: https://rycee.gitlab.io/home-manager/options
  #services.gpg-agent.enableFishIntegration = false;
  #services.gpg-agent.enableScDaemon = false;
}
