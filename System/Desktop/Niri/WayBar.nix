# https://wiki.nixos.org/wiki/Waybar
# https://github.com/nix-community/home-manager/blob/master/modules/programs/waybar.nix

{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 35;
        margin = "15";

        modules-center = [
          "clock"
        ];
      };
    };

    style = ''
      window#waybar {
        background: transparent;
        border-radius: 15px;
      }
    '';
  };
}
