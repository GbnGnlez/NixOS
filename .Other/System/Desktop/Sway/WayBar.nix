# https://wiki.nixos.org/wiki/Waybar

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    networkmanagerapplet
  ];

  wayland.windowManager.sway = {
    config = {
      bars = [
        { command = "waybar"; }
      ];

      startup = [
        { command = "nm-applet"; }
      ];
    };
  };

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [
          "sway/workspaces"
        ];

        "sway/workspaces" = {
          persistent-workspaces = {
            "*" = 5;
          };

          format = "{name}";
        };

        modules-center = [
          "clock"
        ];

        clock = {
          format = "{:%H:%M}";
        };

        modules-right = [
          "backlight"
          "battery"
          "tray"
          "custom/power"
        ];

        backlight = {
          format = "☀ {percent}%";
          tooltip = false;
          on-scroll-up = "light -A 5";
          on-scroll-down = "light -U 5";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "⚡ {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          tooltip-format = "{timeTo}, {capacity}%";
        };

        "custom/power" = {
          format = "⏻";
          tooltip = "Apagar";
          on-click = "systemctl poweroff";
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

      #workspaces {
        padding: 0 10px;
      }

      #clock {
        padding: 0 10px;
      }

      #backlight {
        padding: 0 10px;
      }

      #battery {
        padding: 0 10px;
      }

      #battery.charging {
        color: #26A65B;
      }

      #battery.warning:not(.charging) {
        color: #ffbe61;
      }

      #battery.critical:not(.charging) {
        color: #f66151;
      }

      #tray {
        padding: 0 10px;
      }

      #custom-power {
        padding: 0 10px;
      }
    '';
  };
}
