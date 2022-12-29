{ config, pkgs, ... }:

{
  #Multi-Gen LRU supported in Linux >= 6.0
  systemd.services.enableLruThrashingPrevention = {
    wantedBy = [ "display-manager.service" ];
    after = [ "multi-user.target" ];
    description = "Enable Multi-Gen LRU Thrashing Prevention";
    startLimitBurst = 0;
    serviceConfig = { 
      Type = "oneshot";
      Restart = "on-failure"; 
      RestartSec = 1;
      # Setting to 3000 ms, may cause premature killing, but 3s looks good to me :)
      ExecStart="${pkgs.bash}/bin/bash -c 'echo 3000 > /sys/kernel/mm/lru_gen/min_ttl_ms'";
    };
  };
}
