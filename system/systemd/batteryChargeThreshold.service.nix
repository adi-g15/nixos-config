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
}
