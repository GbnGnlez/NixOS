{
  pkgs,
  DarkTheme,
  Color,
  ...
}:

{
  stylix = {
    enable = true;
    polarity = if DarkTheme then "dark" else "light";

    base16Scheme =
      if DarkTheme then
        "${pkgs.base16-schemes}/share/themes/google-dark.yaml"
      else
        "${pkgs.base16-schemes}/share/themes/google-light.yaml";

    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme.override { color = Color; };
      light = "Papirus-Light";
      dark = "Papirus-Dark";
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = if DarkTheme then "Bibata-Modern-Ice" else "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = {
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      serif = {
        package = pkgs.inter;
        name = "Inter";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        desktop = 10;
        applications = 12;
        terminal = 12;
        popups = 10;
      };
    };
  };
}
