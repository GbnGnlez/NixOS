# https://wiki.nixos.org/wiki/Sway

{
  config,
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    wl-clipboard # Copy/Paste functionality.
    mako # Notification utility.
    kitty
  ];

  # Enable Sway.
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    extraConfig = ''
      input * xkb_layout "us"
      input * xkb_variant "colemak_dh"
    '';
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
