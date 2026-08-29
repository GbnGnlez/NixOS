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
        margin = "15 15 0 15";

        modules-left = [
          "custom/nixos"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "custom/power"
        ];

        "custom/nixos" = {
          format = "";
          tooltip = false;
          on-click = "fuzzel";
        };

        "custom/power" = {
          format = "⏻";
          tooltip = false;
          on-click = "fuzzel --dmenu --prompt='Power: ' < <(printf 'Apagar\\nReiniciar\\nCancelar')";
          on-click-release = "";
        };
      };
    };

    style = ''
      window#waybar {
        background: transparent;
        border-radius: 15px;
      }

      #clock {
        background: #1e1e2e;
        border-radius: 15px;
        padding: 0 15px;
      }

      #custom-nixos {
        background: #1e1e2e;
        border-radius: 15px;
        padding: 0 15px;
        font-size: 20px;
      }

      #custom-power {
        background: #1e1e2e;
        border-radius: 15px;
        padding: 0 15px;
        font-size: 18px;
      }
    '';
  };
}
