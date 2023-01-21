{ pkgs, config, ... }:

{
  services.printing = {
    enable = true;
    drivers = [
      # Gutenprint contains driver for Epson L130 too
      pkgs.gutenprint
    ];
    startWhenNeeded = true;
  };
}
