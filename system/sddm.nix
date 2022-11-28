# https://github.com/michaelpj/nixos-config/blob/e5be6d0f0e431748c0a8c532f9776c14e67ed8c9/nixpkgs/pkgs/sddm-themes.nix

{ pkgs, lib, ... }:

let 

# TODO: Use https://gitlab.com/isseigx/simplicity-sddm-theme/-/blob/master/simplicity/images/background.jpg as background
# Use sddm-theme-clairvoyance in case the aerial theme is too costly

  sddm-aerial-theme = pkgs.stdenv.mkDerivation rec {
    pname = "sddm-aerial-theme";
    version = "1.0.0";

    src = pkgs.fetchFromGitHub {
      owner = "3ximus";
      repo = "aerial-sddm-theme";
      rev = "7dceae9add6602dc499f9df155cdbe0b15c3b94a";
      sha256 = "1xa0f1bf8i78m0zw6z7mly32hwpprd2ci7myi4xkrz8np0gv9zyb";
    };

    phases = [ "installPhase" ];
 
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/$pname
    '';
 };

in {
  environment.systemPackages = with pkgs.libsForQt5.qt5; [
    #gst-libav
    #phonon-qt5-gstreamer
    #gst-plugins-good
    qtquickcontrols
    qtgraphicaleffects
    qtmultimedia
  ];

  services.xserver.displayManager.sddm = {
    # Set theme built above
    theme = "${sddm-aerial-theme}/share/sddm/themes/sddm-aerial-theme";

    # Disable virtual keyboard
    settings = {
      General = {
	InputMethod = "";
      };
    };
  };

  # Enable fprintd
  # services.fprintd.enable = true;
  # services.fprintd.tod.enable = true;

  # @note: Use pkgs.libfprint-2-tod1-goodix if this doesn't work
  # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;
}

# ex: shiftwidth=2 expandtab:
