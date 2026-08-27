# https://wiki.nixos.org/wiki/Waybar

{ ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-center = [
          "clock"
        ];

        modules-right = [
          "network"
        ];

        clock = {
          format = "{:%H:%M}";
        };

        network = {
          format-wifi = "";
          format-ethernet = "󰈀";
          format-disconnected = "󰖪";
          tooltip = false;
        };
      };
    };

    style = ''
      * {
        font-family: sans-serif;
        font-size: 14px;
      }

      window#waybar {
        background: transparent;
      }

      #clock {
        padding: 0 10px;
      }

      #network {
        padding: 0 10px;
      }
    '';
  };
}
