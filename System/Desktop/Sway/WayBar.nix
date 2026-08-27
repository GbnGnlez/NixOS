{ ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-center = [
          "clock"
        ];

        clock = {
          format = "{:%H:%M}";
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

      #clock {
        padding: 0 10px;
      }
    '';
  };
}
