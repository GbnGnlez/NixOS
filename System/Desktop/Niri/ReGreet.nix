# https://wiki.nixos.org/wiki/Niri/en#Greetd

{ pkgs, ... }:

{
  services.greetd.enable = true;

  services.displayManager.regreet = {
    enable = true;

    # Tema GTK Catppuccin Mocha Blue
    theme = {
      name = "catppuccin-mocha-blue-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        variant = "mocha";
        size = "standard";
      };
    };

    # Iconos Catppuccin Papirus
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "blue";
      };
    };

    # Cursores Catppuccin Mocha Blue
    cursorTheme = {
      name = "catppuccin-mocha-blue-cursors";
      package = pkgs.catppuccin-cursors.mochaBlue;
    };

    # Tipografía
    font = {
      name = "Inter";
      package = pkgs.inter;
      size = 11;
    };
  };
}
