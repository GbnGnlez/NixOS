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
    glib # 🌟 Necesario para que las herramientas de configuración se comuniquen con dconf
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

  # 🌟 CONFIGURACIÓN DEL TEMA OSCURO PARA GTK (Firefox, VS Code, etc.)
  gtk = {
    enable = true;

    theme = {
      name = "Breeze-Dark"; # 🌟 Cambiado a Breeze-Dark para activar el tema oscuro nativo
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
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # 🌟 CONFIGURACIÓN PARA APLICACIONES Qt (Dolphin, Kdenlive, etc.)
  qt = {
    enable = true;
    platformTheme.name = "gtk"; # 🌟 Le ordena a Qt heredar el tema Breeze-Dark e iconos de GTK
    style.name = "breeze"; # Aplica el motor de renderizado Breeze
  };

  # 🌟 CONFIGURACIÓN DE DCONF (Fuerza el modo oscuro en aplicaciones Libadwaita/GTK4 modernas)
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
