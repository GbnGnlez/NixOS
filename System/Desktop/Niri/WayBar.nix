{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
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
          "custom/nixos"
          "niri/workspaces"
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

        "custom/power" = {
          format = "";
          tooltip = false;
          on-click = "fuzzel --dmenu --prompt='Power: ' < <(printf 'Apagar\\nReiniciar\\nCancelar')";
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
      }

      window#waybar {
        background: transparent;
        border-radius: 15px;
      }

      #custom-nixos {
        background: #1e1e2e;
        border-radius: 15px;
        padding: 0 15px;
        font-size: 20px;
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

      #clock {
        background: #1e1e2e;
        border-radius: 15px;
        padding: 0 15px;
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
