{ pkgs, config, ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  users.users.ankit = {
    isNormalUser = true;
    description = "Ankit";
    extraGroups = [ "wheel" ];
    shell = pkgs.bash;
  };

  security.doas.extraRules = [
    { users = [ "ankit" ]; keepEnv = true; persist = true; }
  ];

  home-manager.users.ankit = { config, pkgs, ... }: {
    home.packages = with pkgs; [
      anydesk
      bibata-cursors
      google-chrome
      teams
    ];
  };
}
