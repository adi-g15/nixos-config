{ ... }:

{
  imports = [   
    <home-manager/nixos>
  ];

  home-manager.users.adityag = { config, pkgs, ... }: {
    #for i3
    services.betterlockscreen = {
      enable = true;
      arguments = [ "-u /home/adityag/Pictures/windows_wallpapers/9c71f1ecef355c5110a01b0e81cd6f8cfc0466827eb33c236bbd4df299b71cf2.png" ];
    };
   };                          
}

# ex: shiftwidth=2 expandtab:
