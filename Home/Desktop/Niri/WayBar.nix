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

    style = ./WayBar.css;

  };
}
