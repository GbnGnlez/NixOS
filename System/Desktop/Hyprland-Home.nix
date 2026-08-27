# https://wiki.hypr.land/Nix/Hyprland-on-Home-Manager/

{ ... }:

{
  # Terminal utilizada por la configuración inicial de Hyprland.
  programs.kitty.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;

    # UWSM gestiona la sesión/systemd.
    # Evita que Home Manager intente gestionarla también.
    systemd.enable = false;
  };
}
