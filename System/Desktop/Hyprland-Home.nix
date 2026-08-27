{ pkgs, config, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "26.05";

  # Aplicaciones del usuario
  home.packages = with pkgs; [
    thunar
    rofi
  ];

  # Exportar variables de entorno de Home Manager a UWSM
  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

  # Terminal Kitty
  programs.kitty = {
    enable = true;
  };

  # Barra de estado Waybar
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      targets = [ "graphical-session.target" ];
    };
  };

  # Configuración de Hyprland alineada con UWSM
  wayland.windowManager.hyprland = {
    enable = true;

    package = null;
    portalPackage = null;
    systemd.enable = false;

    configType = "hyprlang";

    settings = {
      "$mainMod" = "SUPER";

      # Importar entorno de D-Bus y systemd para que Rofi y Thunar encuentren XDG_DATA_DIRS
      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_DATA_DIRS PATH"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_DATA_DIRS PATH"
      ];

      bind = [
        "$mainMod, Q, exec, kitty"
        "$mainMod, E, exec, thunar"
        "$mainMod, R, exec, rofi -show drun"
        "$mainMod, space, exec, rofi -show drun" # Corregido a minúsculas 'space'
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
      ];
    };
  };
}
