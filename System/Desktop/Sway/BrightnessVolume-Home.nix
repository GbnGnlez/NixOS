# https://wiki.nixos.org/wiki/Sway#Brightness_and_volume

{ lib, ... }:

{
  wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
    # Brightness Controls
    "XF86MonBrightnessDown" = "exec light -U 5";
    "XF86MonBrightnessUp" = "exec light -A 5";

    # Volume Controls
    "XF86AudioRaiseVolume" = "exec wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
    "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
    "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
  };
}
