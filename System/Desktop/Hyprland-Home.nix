# https://wiki.hypr.land/Nix/Hyprland-on-Home-Manager/

{ pkgs, ... }:

{
  # Terminal utilizada por la configuración inicial de Hyprland.
  programs.kitty.enable = true;

  home.packages = with pkgs; [
    waybar
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
