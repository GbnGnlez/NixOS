{
  pkgs,
  Theme,
  Color,
  ...
}:

# let
#   Papirus-Icon-Theme-Custom = pkgs.papirus-icon-theme.overrideAttrs (oldAttrs: {
#     dontFixup = true;
#     nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.papirus-folders ];
#     postInstall = (oldAttrs.postInstall or "") + ''
#       export XDG_DATA_HOME="$out/share"
#       papirus-folders -o -C ${
#         if Color == "Pink" then
#           "pink"
#         else if Color == "Blue" then
#           "blue"
#         else
#           "pink"
#       } -t Papirus-${
#         if Theme == "Light" then
#           "Light"
#         else if Theme == "Dark" then
#           "Dark"
#         else
#           "Dark"
#       }
#     '';
#   });
# in

{
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    bibata-cursors
    inter
    jetbrains-mono
    # papirus-folders
    # Papirus-Icon-Theme-Custom
    # papirus-icon-theme
    glib
  ];

  # Configuración del Cursor (Global para GTK y X11)
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    name =
      if Theme == "Light" then
        "Bibata-Modern-Classic"
      else if Theme == "Dark" then
        "Bibata-Modern-Ice"
      else
        "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 16;
  };

  # CONFIGURACIÓN GTK
  gtk = {
    enable = true;

    theme = {
      name =
        if Theme == "Light" then
          "Breeze"
        else if Theme == "Dark" then
          "Breeze-Dark"
        else
          "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };

    # Catppuccin gestiona los iconos automáticamente via catppuccin-papirus-folders
    iconTheme = {
      name =
        if Theme == "Light" then
          "Papirus-Light"
        else if Theme == "Dark" then
          "Papirus-Dark"
        else
          "Papirus-Dark";

      # package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "Inter";
      size = 10;
      package = pkgs.inter;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme =
        if Theme == "Light" then
          0
        else if Theme == "Dark" then
          1
        else
          1;

      # Barra de título:
      # SIN minimizar | maximizar | cerrar
      gtk-decoration-layout = "menu:maximize,close";
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme =
        if Theme == "Light" then
          0
        else if Theme == "Dark" then
          1
        else
          1;

      # Barra de título:
      # SIN minimizar | maximizar | cerrar
      gtk-decoration-layout = "menu:maximize,close";
    };
  };

  # CONFIGURACIÓN PARA APLICACIONES Qt
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  # DCONF
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme =
        if Theme == "Light" then
          "prefer-light"
        else if Theme == "Dark" then
          "prefer-dark"
        else
          "prefer-dark";
    };
  };
}
