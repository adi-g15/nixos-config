{ config, pkgs, ... }:

{
  systemd.services.batteryChargeThreshold = {
    wantedBy = [ "display-manager.service" ];
    after = [ "multi-user.target" ];
    description = "Set the battery charge threshold";
    startLimitBurst = 0;
    serviceConfig = {
      Type = "oneshot";
      Restart = "on-failure";
      RestartSec = 1;
      ExecStart="${pkgs.bash}/bin/bash -c 'echo 60 > /sys/class/power_supply/BAT0/charge_control_end_threshold'";
    };
  };

  #Multi-Gen LRU supported in Linux >= 6.0
  #systemd.services.enableLruThrashingPrevention = {
  #  wantedBy = [ "display-manager.service" ];
  #  after = [ "multi-user.target" ];
  #  description = "Enable Multi-Gen LRU Thrashing Prevention";
  #  startLimitBurst = 0;
  #  serviceConfig = { 
  #    Type = "oneshot";
  #    Restart = "on-failure"; 
  #    RestartSec = 1;
  #    # Setting to 3000 ms, may cause premature killing, but 3s looks good to me :)
  #    ExecStart="${pkgs.bash}/bin/bash -c 'echo 3000 > /sys/kernel/mm/lru_gen/min_ttl_ms'";
  #  };
  #};

  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  # @ref: https://rycee.gitlab.io/home-manager/options
  services.gpg-agent.enableFishIntegration = false;
  services.gpg-agent.enableScDaemon = false;
}
