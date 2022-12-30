{ ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  # remain consistent with global pkgs, and saves an extra Nix pkgs evaluation
  home-manager.useGlobalPkgs = true;

  # install to /etc/profiles instead of $HOME/.nix-profile
  # pata nhi kaise help krega, lekin future me default hoga ye
  home-manager.useUserPackages = true;

  # error aa rha tha iske bina, jb nix-channel --remove phir --add,--update rebuild krne pe
  home-manager.users.adityag.home.stateVersion = "22.05";
}
