{ ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        modules-left = [
          "hyprland/workspaces"
          "hyprland/submap"
        ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "clock"
        ];

        clock = {
          format = "{:%H:%M - %d/%m/%Y}";
        };
        cpu = {
          format = "CPU: {usage}%";
        };
        memory = {
          format = "RAM: {}%";
        };
      };
    };
    style = ''
      * {
        border: none;
        font-family: "Sans";
        font-size: 13px;
      }
      window#waybar {
        background: rgba(30, 30, 46, 0.8);
        color: #cdd6f4;
      }
    '';
  };
}
