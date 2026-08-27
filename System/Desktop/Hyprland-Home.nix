# https://wiki.hypr.land/Nix/Hyprland-on-Home-Manager/

{ pkgs, ... }:

{
  imports = [
    ./WayBar.nix
  ];

  # 1. Enlazamos de forma declarativa tu archivo Lua
  xdg.configFile."hypr/hyprland.lua".source = ./hyprland.lua;

  # 2. Terminal utilizada por la configuración inicial de Hyprland.
  programs.kitty.enable = true;

  # 3. Lanzador automático oficial para Bash usando UWSM
  programs.bash = {
    enable = true;
    profileExtra = ''
      if uwsm check may-start; then
        exec uwsm start hyprland.desktop
      fi
    '';
  };

  # 🌟 4. CONFIGURACIÓN DEL TEMA OSCURO GLOBAL 🌟

  # Configuración dconf: Obliga a aplicaciones GTK4/Libadwaita a preferir el tema oscuro [9]
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # Configuración de apariencia para aplicaciones GTK (Firefox, VS Code, etc.)
  gtk = {
    enable = true;

    # Tema visual oscuro (usamos Breeze-Dark para máxima compatibilidad con Dolphin)
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk; # Tema oficial de KDE 6 portado a GTK
    };

    # Pack de iconos oscuros
    iconTheme = {
      name = "breeze-dark";
      package = pkgs.kdePackages.breeze-icons;
    };

    # Cursor consistente y elegante
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  # Configuración de apariencia para aplicaciones Qt (Dolphin, etc.)
  qt = {
    enable = true;
    platformTheme.name = "gtk"; # Le dice a Qt que herede el tema y cursores de GTK
    style.name = "breeze"; # Aplica el motor de renderizado Breeze
  };

  # 5. Paquetes de usuario
  home.packages = with pkgs; [
    hyprlock
    hyprlauncher
    kdePackages.dolphin

    # Asegura que las herramientas de configuración de temas se comuniquen bien con dconf [9]
    glib
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false; # Evita conflictos con UWSM
  };
}
