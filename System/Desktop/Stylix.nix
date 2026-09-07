# System/Desktop/Stylix.nix
{
  pkgs,
  DarkTheme,
  Color,
  ...
}:

let
  iconThemeName = if DarkTheme then "Papirus-Dark" else "Papirus-Light";
  papirusPersonalizado = pkgs.papirus-icon-theme.override {
    color = Color;
  };
in

{
  stylix = {
    enable = true;
    polarity = if DarkTheme then "dark" else "light";

    base16Scheme =
      if DarkTheme then
        "${pkgs.base16-schemes}/share/themes/default-dark.yaml"
      else
        "${pkgs.base16-schemes}/share/themes/default-light.yaml";

    cursor = {
      package = pkgs.bibata-cursors;
      name = if DarkTheme then "Bibata-Modern-Ice" else "Bibata-Modern-Classic";
      size = 24;
    };
  };

  # 1. Disponibiliza el paquete de iconos modificado globalmente
  environment.systemPackages = [
    papirusPersonalizado
  ];

  # 2. Inyección de Papirus en aplicaciones GTK 3 y GTK 4 a nivel sistema
  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    s
        [Settings]
        gtk-icon-theme-name=${iconThemeName}
  '';

  environment.etc."xdg/gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-icon-theme-name=${iconThemeName}
  '';
}
