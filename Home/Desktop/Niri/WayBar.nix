{ pkgs, lib, ... }:

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
        height = 30;
        spacing = 4;

        modules-left = [
          "niri/workspaces"
          "custom/sep"
          "niri/window"
          "custom/sep"
        ];

        modules-center = [ ];

        modules-right = [
          "custom/sep"
          "network"
          "custom/sep"
          "cpu"
          "custom/sep"
          "memory"
          "custom/sep"
          "disk"
          "custom/sep"
          "battery"
          "custom/sep"
          "clock"
          "custom/sep"
          "tray"
        ];

        "niri/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{name}";
        };

        "niri/window" = {
          max-length = 40;
          separate-outputs = false;
        };

        tray = {
          spacing = 10;
        };

        clock = {
          format = "󰥔 {:%H:%M}";
        };

        cpu = {
          format = "CPU: {usage}%";
          tooltip = false;
        };

        memory = {
          format = "Mem: {used}GiB";
        };

        disk = {
          interval = 60;
          path = "/";
          format = "Disk: {free}";
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };

          format = "Bat: {capacity}% {icon} {time}";
          format-plugged = "{capacity}% ";
          format-alt = "Bat {capacity}%";
          format-time = "{H}:{M}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        network = {
          format = "Online";
          format-disconnected = "Disconnected ⚠";
        };

        "custom/sep" = {
          format = "|";
          interval = 0;
        };
      };
    };

    style = lib.mkForce ./WayBar.css;
  };
}
