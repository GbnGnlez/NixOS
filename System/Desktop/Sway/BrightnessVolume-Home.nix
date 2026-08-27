# https://wiki.nixos.org/wiki/Sway#Brightness_and_volume

{ lib, ... }:

{
  wayland.windowManager.sway = {
    config = {
      keybindings = lib.mkOptionDefault {
        # Brightness Controls
        "XF86MonBrightnessDown" = "exec light -U 10";
        "XF86MonBrightnessUp" = "exec light -A 10";

        # Volume Controls
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +1%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -1%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
      };
    };
  };
}
