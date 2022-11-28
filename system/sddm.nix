# https://github.com/michaelpj/nixos-config/blob/e5be6d0f0e431748c0a8c532f9776c14e67ed8c9/nixpkgs/pkgs/sddm-themes.nix

{ pkgs, ... }:

let 

  sddm-sugar-dark = pkgs.stdenv.mkDerivation rec {
    pname = "sddm-sugar-dark-theme";
    version = "1.2";

    src = pkgs.fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-sugar-dark";
      rev = "v${version}";
      sha256 = "0gx0am7vq1ywaw2rm1p015x90b75ccqxnb1sz3wy8yjl27v82yhb";
    };

    phases = [ "installPhase" ];
 
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/sugar-dark
    '';
 };

in {

  services.xserver.displayManager.sddm.theme = "${sddm-sugar-dark}/share/sddm/themes/sugar-dark";
}

# ex: shiftwidth=2 expandtab:
