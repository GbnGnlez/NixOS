# WayBar.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    networkmanagerapplet
  ];

  # Habilita SwayNC (SwayNotificationCenter) como servicio
  services.swaync.enable = true;

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [
          "hyprland/workspaces"
        ];

        "hyprland/workspaces" = {
          format = "{name}";
          persistent-workspaces = {
            "*" = 5;
          };
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
          "custom/notification"
          "custom/power"
        ];

        backlight = {
          format = "☀ {percent}%";
          tooltip = false;
          # Uses brightnessctl to match your Hyprland keybindings
          on-scroll-up = "brightnessctl set 5%+";
          on-scroll-down = "brightnessctl set 5%-";
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

        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "󰂚<span foreground='red'><sup>󰅂</sup></span>";
            none = "󰂚";
            dnd-notification = "󰂛<span foreground='red'><sup>󰅂</sup></span>";
            dnd-none = "󰂛";
            inhibited-notification = "󰂚<span foreground='red'><sup>󰅂</sup></span>";
            inhibited-none = "󰂚";
            dnd-inhibited-notification = "󰂛<span foreground='red'><sup>󰅂</sup></span>";
            dnd-inhibited-none = "󰂛";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        "custom/power" = {
          format = "⏻";
          tooltip = "Apagar";
          on-click = "systemctl poweroff";
        };
      };
    };

    style = ''
      /* Removed hardcoded font-family and font-size to allow Stylix to manage typography */

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

      #custom-notification {
        padding: 0 10px;
      }

      #custom-power {
        padding: 0 10px;
      }
    '';
  };
}
