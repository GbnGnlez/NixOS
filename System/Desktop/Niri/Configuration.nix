# https://wiki.nixos.org/wiki/Niri/en

{
  imports = [
    # ./ReGreet.nix
  ];

  # https://wiki.nixos.org/wiki/Niri/en#Installation
  programs.niri.enable = true;

  # https://wiki.nixos.org/wiki/Niri/en#Additional_Setup
  security.polkit.enable = true; # polkit
  services.gnome.gnome-keyring.enable = true; # secret service
  # security.pam.services.swaylock = { };

  # https://wiki.nixos.org/wiki/Niri/en#IME_not_working_on_Electron_apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
