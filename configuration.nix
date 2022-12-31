# Isme improvements applications ke config me kar sakta hu

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./system/networking.nix
      ./system/printing.nix
      ./system/systemd/main.nix
      ./system/unbound.nix
      ./system/sddm.nix
      ./system/sysctl-configs.nix
      ./system/home-manager-global.nix
      ./user/adityag.nix
    ];

  boot = {
    # Nahi chahiye mereko plymouth
    plymouth.enable = false;

    # TODO: initrd disable kar

    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
      timeout=0;
    };

    # Below or equals KERN_CRIT
    consoleLogLevel = 2;

    # Custom kernel ke hisaab se rkha hu
    kernelParams = [
      "quiet"
      "panic=10"
      "rw"
    ];
  };

  # Use terminus fonts
  console = {
    font = "ter-132n";
    packages = with pkgs; [ terminus_font ];
  };

  # @adi-g15 appstream metadata specification'
  appstream.enable = true;

  # @adi-g15 doesn't work, these commands end up in /nix/store/*local-cmds
  # boot.postBootCommands = "echo 60 > /sys/class/power_supply/BAT0/charge_control_end_threshold";

  # @adi-g15
  boot.runSize = "512m";
  boot.supportedFilesystems = [ "vfat" "btrfs" ];
  boot.tmpOnTmpfs = true;

  boot.tmpOnTmpfsSize = "2g";
  security.doas.enable = true;
  security.sudo.enable = true;

  # @adi-g15 neovim
  environment.variables.EDITOR = "nvim";
  programs.neovim.enable = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;

  # Set your time zone
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5 = {
    enable = true;
  };

  # probably not available in this version of nix: https://github.com/NixOS/nixpkgs/pull/177389
  # services.xserver.desktopManager.plasma5.excludePackages = [ pkgs.plasma5Packages.elisa ]; };

  # @adi-g15
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;  # Use to kr nhi rha hu abhi na, dekha jayega manually enable kaise kare
  # hardware.opengl.enable = true; # Iske bina kaam kar rha h to karne de
  hardware.pulseaudio.enable = true;
  hardware.cpu.amd.updateMicrocode = true;

  nixpkgs.config.allowUnfree = true; #to allow installing anydesk

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # https://nixos.wiki/wiki/Command_Shell
  programs.zsh.enable = true;
  
  environment.shells = [ pkgs.zsh ];
  environment.binsh = "${pkgs.dash}/bin/dash";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
      clang
      dash
      earlyoom
      firefox-bin
      flameshot
      gvfs
      htop
      libreoffice-qt # Can also use libreoffice-still
      lightly-qt
      lynx
      man-pages # Linux dev manual pages
      mlocate
      neofetch
      neovim
      office-code-pro
      plasma-nm
      # kamoso #ERROR
      # mariadb-server #ERROR
      util-linux
      virt-manager
      vlc
      wget
  ];

  # https://nixos.wiki/wiki/Virt-manager
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # stdenv = pkgs.clangStdenv;

  services.locate.enable = true;

  # https://libreddit.tiekoetter.com/r/NixOS/comments/w1jqd3/ive_made_some_changes_to_etcconfigurationnix/ihpwzen
#  system.nixos.label = (lib.maybeEnv "NIXOS_LABEL"
#(lib.concatStringsSep "-" ((lib.sort (x: y: x < y) config.system.nixos.tags) ++
#                           [(lib.maybeEnv "NIXOS_LABEL_VERSION" config.system.nixos.version)
#                             "g${inputs.self.shortRev}"
#                           ])));

  # @ref: https://nixos.wiki/wiki/Storage_optimization
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

