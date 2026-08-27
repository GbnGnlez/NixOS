# https://wiki.nixos.org/wiki/Hyprland

{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  # Integración de sistema para Thunar y servicios D-Bus/GVfs
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  services.gvfs.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    thunar
  ];
}
