# https://wiki.hypr.land/Nix/Hyprland-on-NixOS/
# https://wiki.nixos.org/wiki/Hyprland

{ ... }:

{
  services.getty.autologinUser = "nixos";

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
