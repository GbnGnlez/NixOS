# https://wiki.nixos.org/wiki/Sway#Screenshots

{ config, lib, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config =
      let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in
      {
        modifier = "Mod4";
        keybindings = lib.mkOptionDefault {

          # Super + Shift + S
          # Screenshot a selection that saves to ~/Screenshots and copies to clipboard.
          "${modifier}+Shift+s" =
            "exec selection=$(slurp) && grim -g \"$selection\" - | tee ~/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy";

          # Print Screen Button
          # Screenshot the currently focused screen, save to ~/Screenshots and copy to clipboard.
          "Print" =
            "exec grimshot save output - | tee ~/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy";

        };
      };
  };
}
