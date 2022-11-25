# Isme improvements applications ke config me kar sakta hu

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./systemd-services.nix
      ./home-manager-config.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {

    # kernelPackages = pkgs.linuxPackages_6_0;

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

  # @adi-g15
  boot.postBootCommands = "echo 60 > /sys/class/power_supply/BAT0/charge_control_end_threshold";

  # @adi-g15
  boot.runSize = "512m";
  boot.supportedFilesystems = [ "vfat" "btrfs" ];
  boot.tmpOnTmpfs = true;
  boot.tmpOnTmpfsSize = "2g";
  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    Network = { EnableIPv6 = true; };
    Settings = { AutoConnect = true; };
  };

  networking.networkmanager.wifi.backend = "iwd";
  networking.networkmanager.wifi.macAddress = "random";
  # networking.networkmanager.wifi.powersave = true;
  nix.settings.auto-optimise-store = true;
  security.doas.enable = true;
  security.sudo.enable = true;
  security.doas.extraRules = [
    { users = [ "adityag" ]; keepEnv = true; persist = true;  }
  ];

  # Can add:
  # permit nopass adityag as root cmd /usr/bin/psd-overlay-helper
  security.doas.extraConfig = ''
    deny adityag as root cmd su
    deny adityag as root cmd rm args -rf
    deny adityag as root cmd rm args -r
  '';

  # @adi-g15 nftables naya wala h, usko enable krke firewall disable krna hoga
  networking.nftables.enable = true;
  networking.networkmanager.firewallBackend = "nftables";
  networking.firewall.enable = false;
  networking.hostName = "adityag409da"; # Define your hostname.
  networking.networkmanager.enable = true;

  # @adi-g15 neovim
  environment.variables.EDITOR = "nvim";
  programs.neovim.enable = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;

  # Set your time zone
  time.timeZone = "Asia/Kolkata";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
#    excludePackages = with pkgs.libsForQt5; [
#      elisa
#      oxygen
#      khelpcenter
#      plasma-browser-integration
#      print-manager
#    ];
  };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # @adi-g15
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;  # Use to kr nhi rha hu abhi na, dekha jayega manually enable kaise kare
  # hardware.opengl.enable = true; # Iske bina kaam kar rha h to karne de
  hardware.pulseaudio.enable = true;
  hardware.cpu.amd.updateMicrocode = true;

  nixpkgs.config.allowUnfree = true; #to allow installing anydesk

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # https://nixos.wiki/wiki/Command_Shell
  programs.zsh.enable = true;
  users.users.adityag.shell = pkgs.zsh;
  environment.shells = [ pkgs.zsh ];
  environment.binsh = "${pkgs.dash}/bin/dash";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.adityag = {
    isNormalUser = true;
    description = "Aditya Gupta";
    extraGroups = [ "wheel" "libvirtd" ];
    packages = []; # managed by home-manager
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
      clang
      dash
      earlyoom
      firefox-bin
      flameshot
      gparted
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.locate.enable = true;

  # https://libreddit.tiekoetter.com/r/NixOS/comments/w1jqd3/ive_made_some_changes_to_etcconfigurationnix/ihpwzen
#  system.nixos.label = (lib.maybeEnv "NIXOS_LABEL"
#(lib.concatStringsSep "-" ((lib.sort (x: y: x < y) config.system.nixos.tags) ++
#                           [(lib.maybeEnv "NIXOS_LABEL_VERSION" config.system.nixos.version)
#                             "g${inputs.self.shortRev}"
#                           ])));

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

