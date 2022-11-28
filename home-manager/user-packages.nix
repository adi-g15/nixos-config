{ ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  # remain consistent with global pkgs, and saves an extra Nixpkgs evaluation
  home-manager.useGlobalPkgs = true;

  # install to /etc/profiles instead of $HOME/.nix-profile
  # pata nhi kaise help krega, lekin future me default hoga ye
  home-manager.useUserPackages = true;

  home-manager.users.adityag = { config, pkgs, ... }: {
    home.packages = with pkgs; [
      anydesk
      #arduino-cli
      bibata-cursors
      #cgdb
      #cmake
      #codespell
      #duplicacy
      gh
      git
      #google-cloud-sdk
      google-drive-ocamlfuse
      python3
      #rclone
      ripgrep
      #rmlint
      #rustup
      teams
      trash-cli
      vscodium

      #vim-plug
      #vimPlugins.vim-plug

      yt-dlp-light
    ];
  };
}

# ex: shiftwidth=2 expandtab: 
