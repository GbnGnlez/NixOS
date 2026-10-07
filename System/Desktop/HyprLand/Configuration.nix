# https://wiki.hypr.land/Nix/Hyprland-on-NixOS/
# https://wiki.nixos.org/wiki/Hyprland

{ pkgs, ... }:

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

  services.gvfs.enable = true;

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];

    # Asigna explícitamente qué portal atiende cada función
    config = {
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
        # Hyprland no implementa selector de archivos, se delega a GTK
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };
  };
}
