# https://wiki.hypr.land/Nix/Hyprland-on-Home-Manager/

{ pkgs, ... }:

{
  imports = [
    ./WayBar.nix
  ];

  # Enlazamos de forma declarativa tu archivo Lua a la ruta de configuración de Hyprland
  xdg.configFile."hypr/hyprland.lua".source = ./hyprland.lua;

  # Lanzador automático oficial para Bash usando UWSM
  programs.bash = {
    enable = true;
    profileExtra = ''
      if uwsm check may-start; then
        exec uwsm start hyprland.desktop
      fi
    '';
  };

  # Terminal utilizada por la configuración inicial de Hyprland.
  programs.kitty.enable = true;

  home.packages = with pkgs; [
    hyprlock
    hyprlauncher
    kdePackages.dolphin
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    # UWSM gestiona la sesión/systemd.
    # Evita que Home Manager intente gestionarla también.
    systemd.enable = false;
  };
}
