# https://wiki.nixos.org/wiki/Hyprland
# https://wiki.hypr.land/Nix/Hyprland-on-NixOS/

{ ... }:

{
  programs.hyprland = {
    enable = true;

    # Integración recomendada con systemd.
    withUWSM = true;

    # Compatibilidad con aplicaciones X11.
    xwayland.enable = true;
  };
}
