# https://wiki.nixos.org/wiki/Sway

{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.desktop.swayfx;
in

{
  imports = [
    ./BrightnessVolume.nix
    ./Screenshots.nix
  ];

  environment.systemPackages = with pkgs; [
    wl-clipboard # Copy/Paste functionality.
    mako # Notification utility.
    kitty
    thunar
    kdePackages.dolphin
  ];

  # Enable Sway.
  programs.sway = {
    enable = true;

    package = if cfg.enable then pkgs.swayfx else pkgs.sway;

    wrapperFeatures.gtk = true;
  };

  security.polkit.enable = true;

  services.greetd.enable = true;
  services.displayManager.regreet.enable = true;

  # Enables Gnome Keyring to store secrets for applications.
  services.gnome.gnome-keyring.enable = true;

  security.pam.services = {
    greetd.enableGnomeKeyring = true;
    swaylock.enableGnomeKeyring = true;
  };
}
