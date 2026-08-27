# https://wiki.nixos.org/wiki/Sway#SwayFX

{ pkgs, ... }:

{
  wayland.windowManager.sway = {
    # Needed to build without errors.
    checkConfig = false;

    # SwayFX options must be configured through extraConfig.
    extraConfig = ''
      shadows enable
      corner_radius 11
      blur_radius 7
      blur_passes 2
    '';
  };
}
