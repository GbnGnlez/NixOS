# https://wiki.nixos.org/wiki/Waybar

{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 35;
        spacing = 15;

        modules-center = [
          "clock"
        ];
      };
    };
  };
}
