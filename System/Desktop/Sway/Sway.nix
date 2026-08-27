# https://wiki.nixos.org/wiki/Sway

{ pkgs, ... }:

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
