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
          "tray"
        ];

        backlight = {
          format = "☀ {percent}%";
          tooltip = false;
          on-scroll-up = "light -A 5";
          on-scroll-down = "light -U 5";
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

      #tray {
        padding: 0 10px;
      }
    '';
  };
}
