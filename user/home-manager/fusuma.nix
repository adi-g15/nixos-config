{ ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.adityag = { config, pkgs, ... }: {
    services.fusuma = {
      enable = true;
      extraPackages = with pkgs; [ coreutils ruby xdotool ];
      # @ref: https://github.com/iberianpig/fusuma/wiki/KDE-to-mimic-MacOS
      # switched actions for 3 fingers and 4 fingers
      settings = {
        swipe = {
          "4" = {
            up = {
              command = "xdotool key Meta+Prior"; # Maximize window, Prior=Page_Up
            };
            down = {
              command = "xdotool key Meta+Next"; # Minimize window, Next=Page_Down
            };
          };
          "3" = {
            right = {
              command = "xdotool key ctrl+Tab"; # Next tab
            };
            left = {
              command = "xdotool key ctrl+shift+Tab"; # Previous tab
            };
            up = {
              command = "xdotool key ctrl+t"; # Open new tab
              keypress = {
                LEFTSHIFT = {
                  command = "xdotool key --clearmodifiers ctrl+shift+t"; # Open last closed tab
                };
              };
            };
            down = {
              command = "xdotool key ctrl+w"; # Close tab
            };
          };
        };
	rotate = {
	  "2" = {
	    clockwise = {
	      command = "konsole";
	    };
	    counterclockwise = {
	      command = "firefox";
	    };
	  };
	};
      };
    };
  };
}

# ex: shiftwidth=2 expandtab: 
