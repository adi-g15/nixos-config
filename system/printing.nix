{ pkgs, config, ... }:

{
  services.printing = {
    enable = true;
    drivers = [
      # Gutenprint contains driver for Epson L130 too
      pkgs.gutenprint
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };
}
