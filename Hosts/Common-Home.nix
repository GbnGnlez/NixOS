{
  pkgs,
  ThemeColor ? "pink",
  IconVariant ? "Light",
  CursorVariant ? "Classic",
  CursorSize ? 16,
  FontSize ? 10,
  ...
}:

let
  Papirus-Icon-Theme-Custom = pkgs.papirus-icon-theme.overrideAttrs (oldAttrs: {
    dontFixup = true;
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.papirus-folders ];
    postInstall = (oldAttrs.postInstall or "") + ''
      export XDG_DATA_HOME="$out/share"
      papirus-folders -o -C ${ThemeColor} -t Papirus-${IconVariant}
    '';
  });
in

{
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    bibata-cursors
    inter
    jetbrains-mono
    papirus-folders
    Papirus-Icon-Theme-Custom
    glib
  ];

  # Configuración del Cursor (Global para GTK y X11)
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-${CursorVariant}";
    package = pkgs.bibata-cursors;
    size = CursorSize;
  };

  # CONFIGURACIÓN GTK
  gtk = {
    enable = true;

    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };

    iconTheme = {
      name = "Papirus-${IconVariant}";
      package = Papirus-Icon-Theme-Custom;
    };

    font = {
      name = "Inter";
      size = FontSize;
      package = pkgs.inter;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;

      # Barra de título:
      # SIN minimizar | maximizar | cerrar
      gtk-decoration-layout = "menu:maximize,close";
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;

      # Barra de título:
      # SIN minimizar | maximizar | cerrar
      gtk-decoration-layout = "menu:maximize,close";
    };
  };

  # CONFIGURACIÓN PARA APLICACIONES Qt
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "breeze";
  };

  # DCONF
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
