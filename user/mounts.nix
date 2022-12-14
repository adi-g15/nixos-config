{ pkgs, config, ... }:

{
  fileSystems."/home/adityag/backup" =
    {
      device = "/dev/disk/by-uuid/0c3283d1-aa4d-4b0e-8ae3-e0f65aba7d6a";
      fsType = "btrfs";
      options = [ "compress-force=zstd:9" "noatime" "subvol=backup" ];
    };

  fileSystems."/home/adityag/backup/motorola" =
    {
      device = "/dev/disk/by-uuid/0c3283d1-aa4d-4b0e-8ae3-e0f65aba7d6a";
      fsType = "btrfs";
      options = [ "compress-force=zstd:9" "noatime" "subvol=motorola_one_power" ];
    };

  fileSystems."/home/adityag/projects" =
    { device = "/dev/disk/by-uuid/1bcea90d-7cba-4aa8-91fe-ccd177d1ce79";
      fsType = "btrfs";
      options = [ "noatime" "subvol=projects" ];
    };

  fileSystems."/home/adityag/os-projects" =
    { device = "/dev/disk/by-uuid/1bcea90d-7cba-4aa8-91fe-ccd177d1ce79";
      fsType = "btrfs";
      options = [ "noatime" "subvol=os-projects" ];
    };

  fileSystems."/home/adityag/shared-drive" =                                                                                                          
    { device = "none";                                                                                                                                
      fsType = "tmpfs";                                                                                                                               
      options = [ "rw" "noatime" "async" "nosuid" "noexec" "huge=advise" "size=3g" ];
    };
}
