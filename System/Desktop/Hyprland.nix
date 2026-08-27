# https://wiki.hypr.land/Nix/Hyprland-on-NixOS/
# https://wiki.nixos.org/wiki/Hyprland

{ ... }:

{
  # 1. Autologin en la consola TTY1 al bootear (Sin Display Manager)
  services.getty.autologinUser = "nixos"; # <-- Reemplaza "nixos" por tu usuario real si fuera diferente

  programs.hyprland = {
    enable = true;

    # Integración recomendada con systemd.
    withUWSM = true;

    # Permite ejecutar aplicaciones X11 dentro de Hyprland.
    xwayland.enable = true;
  };

  # PAM necesario para que Hyprlock pueda autenticar al usuario.
  security.pam.services.hyprlock = { };

  # A set of environment variables used in the global environment.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
