{
  pkgs,
  DarkTheme ? false,
  ...
}:

{
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    bibata-cursors
    inter
    gtk3
    papirus-icon-theme
    jetbrains-mono
    glib
  ];

  # Configuración del Cursor (Global para GTK y X11)
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    name = if DarkTheme then "Bibata-Modern-Ice" else "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 16;
  };

  gtk = {
    enable = true;

    theme = {
      name = if DarkTheme then "Breeze-Dark" else "Breeze";
      package = pkgs.kdePackages.breeze-gtk;
    };

    iconTheme = {
      name = if DarkTheme then "Papirus-Dark" else "Papirus-Light";
      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "Inter";
      size = 10;
      package = pkgs.inter;
    };
  };
}
