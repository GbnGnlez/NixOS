# https://wiki.nixos.org/wiki/Sway

{ ... }:

{
  imports = [
    ./WayBar.nix
    ./BrightnessVolume-Home.nix
    ./Screenshots-Home.nix
    # ./Touchpad.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "kitty";
      startup = [
        # Launch on start
        { command = "nm-applet firefox"; }
      ];

      bars = [
        {
          command = "waybar";
        }
      ];

      input = {
        "*" = {
          xkb_layout = "us";
          xkb_variant = "colemak_dh";
        };
      };
    };
  };
}
