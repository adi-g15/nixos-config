{ pkgs, config, ... }:

{
  imports = [
    <home-manager/nixos>
    ./mounts.nix
    ./home-manager/nvim-config.nix
    ./home-manager/flameshot.nix
    ./home-manager/fusuma.nix
    ./home-manager/git.nix
    ./home-manager/kdeconnect.nix
    ./home-manager/redshift.nix
    ./home-manager/vscode.nix
    ./home-manager/zsh.nix
    ./home-manager/configs.nix
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.adityag = {
    isNormalUser = true;
    description = "Aditya Gupta";
    extraGroups = [ "wheel" "libvirtd" "input" ];       # 'input' for fusuma
    packages = [];
    shell = pkgs.zsh;
  };

  home-manager.users.adityag = { config, pkgs, ... }: {
    home.packages = with pkgs; [
      #android-tools
      anydesk
      #arduino-cli
      bibata-cursors
      #cgdb
      #cmake
      #codespell
      #duplicacy
      gh
      git
      gparted
      #google-cloud-sdk
      google-drive-ocamlfuse
      home-manager
      killall
      nodejs-16_x           # for nvim, copilot
      python3
      rclone
      ripgrep
      #rmlint
      #rustup
      teams
      transmission-qt
      trash-cli
      #vim-plug
      #vimPlugins.vim-plug
 
      yt-dlp-light
    ];
  };

  security.doas.extraRules = [
    { users = [ "adityag" ]; keepEnv = true; persist = true;  }
  ];
  
  # @adi What happens if multiple users set this string?
  # Can add:
  # permit nopass adityag as root cmd /usr/bin/psd-overlay-helper
  security.doas.extraConfig = ''
    deny adityag as root cmd su
    deny adityag as root cmd rm args -rf
    deny adityag as root cmd rm args -r
  '';

  # FUTURE: for customising firefox, see https://github.com/NixOS/nixpkgs/blob/3d9c0b6bdb5d6ee7126b6362167550c74590d612/nixos/modules/programs/firefox.nix#L39-L66
}

# ex: shiftwidth=2 expandtab: 
