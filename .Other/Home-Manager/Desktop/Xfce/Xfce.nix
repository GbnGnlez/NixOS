# https://wiki.nixos.org/wiki/Xfce

{ pkgs, ... }:

{
  programs.xfconf.enable = true;

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };

    displayManager = {
      lightdm.enable = true;
    };
  };

  services.displayManager.defaultSession = "xfce";

  # Paquetes traídos directamente del nivel superior de pkgs
  environment.systemPackages = with pkgs; [
    xfce4-whiskermenu-plugin
    xfce4-pulseaudio-plugin
    xfce4-clipman-plugin
    xfce4-screenshooter
  ];
}
