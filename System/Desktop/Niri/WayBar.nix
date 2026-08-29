{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    papirus-icon-theme
  ];

  programs.waybar = {
    enable = true;

    # ...

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

      #clock {
        background: #1e1e2e;
        border-radius: 15px;
        padding: 0 15px;
      }
    '';
  };
}
