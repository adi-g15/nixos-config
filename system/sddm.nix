# https://github.com/michaelpj/nixos-config/blob/e5be6d0f0e431748c0a8c532f9776c14e67ed8c9/nixpkgs/pkgs/sddm-themes.nix

{ pkgs, lib, ... }:

let 

# TODO: Use https://gitlab.com/isseigx/simplicity-sddm-theme/-/blob/master/simplicity/images/background.jpg as background in future, read README at https://github.com/MarianArlt/kde-plasma-chili for info, probably with awk

  sddm-kde-plasma-chili = pkgs.stdenv.mkDerivation rec {
    pname = "sddm-kde-plasma-chili";
    version = "0.5.5";

    src = pkgs.fetchFromGitHub {
      owner = "MarianArlt";
      repo = "kde-plasma-chili";
      rev = "a371123959676f608f01421398f7400a2f01ae06";
      sha256 = "17pkxpk4lfgm14yfwg6rw6zrkdpxilzv90s48s2hsicgl3vmyr3x";
    };

    phases = [ "installPhase" ];
 
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/kde-plasma-chili
    '';
 };

in {

  services.xserver.displayManager.sddm.theme = "${sddm-kde-plasma-chili}/share/sddm/themes/kde-plasma-chili";
}

# ex: shiftwidth=2 expandtab:
