# https://wiki.nixos.org/wiki/Waybar
# https://github.com/nix-community/home-manager/blob/master/modules/programs/waybar.nix

{ pkgs, ... }:

let
  papirus = pkgs.papirus-icon-theme;
in
{
  home.packages = [
    papirus
  ];

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 35;
        margin = "15 15 0 15";

        modules-left = [
          "image/nixos"
          "niri/workspaces"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "image/power"
        ];

        "image/nixos" = {
          path = "${papirus}/share/icons/Papirus-Dark/64x64/places/distributor-logo-nixos.svg";
          size = 22;
          tooltip = false;
          on-click = "fuzzel";
        };

        "niri/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          all-outputs = true;

          format-icons = {
            active = "";
            default = "";
          };
        };

        "clock" = {
          tooltip = false;
        };

        "image/power" = {
          path = "${papirus}/share/icons/Papirus-Dark/64x64/actions/system-shutdown.svg";
          size = 20;
          tooltip = false;
          on-click = "fuzzel --dmenu --prompt='Power: ' < <(printf 'Apagar\\nReiniciar\\nCancelar')";
        };
      };
    };

    style = ''
      window#waybar {
        background: transparent;
        border-radius: 15px;
      }

      #image-nixos {
        background: #1e1e2e;
        border-radius: 15px;
        padding: 0 15px;
      }

      #clock {
        background: #1e1e2e;
        border-radius: 15px;
        padding: 0 15px;
      }

      #workspaces {
        background: #1e1e2e;
        border-radius: 15px;
        padding: 0 5px;
      }

      #workspaces button {
        color: #cdd6f4;
        padding: 0 8px;
        margin: 0 2px;
        border-radius: 10px;
      }

      #workspaces button.active {
        color: #89b4fa;
        background: #313244;
      }

      #image-power {
        background: #1e1e2e;
        border-radius: 15px;
        padding: 0 15px;
      }
    '';
  };
}
