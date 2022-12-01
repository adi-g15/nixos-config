# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "rtsx_usb_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "size=2G" "mode=755" ];  # mode=755, so only root has write access
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/1bcea90d-7cba-4aa8-91fe-ccd177d1ce79";
      fsType = "btrfs";
      options = [ "compress=none" "subvol=home" ];
    };

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

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/1bcea90d-7cba-4aa8-91fe-ccd177d1ce79";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" "subvol=nix" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/A068-166C";
      fsType = "vfat";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
