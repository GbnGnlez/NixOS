# WayBar.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    networkmanagerapplet
  ];

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
          "wireplumber"
          "backlight"
          "battery"
          "tray"
          "custom/notification"
          "custom/power"
        ];

        wireplumber = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 {volume}%";
          format-icons = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
          max-volume = 100;
          scroll-step = 5.0;
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          tooltip = false;
        };

        backlight = {
          format = "☀ {percent}%";
          tooltip = false;
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
            notification = "󰂚";
            none = "󰂚";
            dnd-notification = "󰂛";
            dnd-none = "󰂛";
            inhibited-notification = "󰂚";
            inhibited-none = "󰂚";
            dnd-inhibited-notification = "󰂛";
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
      /* Integración total con Stylix (Variables Base16 automáticas) */
      window#waybar {
        background: transparent;
      }

      #workspaces,
      #clock,
      #wireplumber,
      #backlight,
      #battery,
      #tray,
      #custom-notification,
      #custom-power {
        padding: 0 10px;
      }

      #wireplumber.muted {
        color: @base08;
      }

      #battery.charging {
        color: @base0B;
      }

      #battery.warning:not(.charging) {
        color: @base0A;
      }

      #battery.critical:not(.charging) {
        color: @base08;
      }
    '';
  };
}
