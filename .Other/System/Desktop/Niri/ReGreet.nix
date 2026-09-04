# https://wiki.nixos.org/wiki/Niri/en#Greetd

{
  pkgs,
  Theme,
  Color,
  ...
}:

{
  services.greetd.enable = true;

  services.displayManager.regreet = {
    enable = true;

    # Tema GTK Catppuccin Mocha Blue
    theme = {
      name = "catppuccin-${Theme}-${Color}-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ Color ];
        variant = Theme;
        size = "standard";
      };
    };

    # Iconos Catppuccin Papirus
    iconTheme = {
      name = if Theme == "latte" then "Papirus-Light" else "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = Theme;
        accent = Color;
      };
    };

    # Cursores
    cursorTheme = {
      name = if Theme == "latte" then "Bibata-Modern-Classic" else "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };

    # Tipografía
    font = {
      name = "Inter";
      package = pkgs.inter;
      size = 10;
    };
  };
}
