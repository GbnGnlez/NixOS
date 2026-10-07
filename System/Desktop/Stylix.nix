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

    image = pkgs.fetchurl (
      if DarkTheme then
        {
          url = "https://raw.githubusercontent.com/KDE/plasma-workspace-wallpapers/master/Waterfall/contents/images_dark/5120x2880.png";
          hash = "sha256-R3N/l3E3/h9K762/m79rM/C0E9p34024N6r6X1k6m04="; # Reemplazar con el hash correcto si difiere
        }
      else
        {
          url = "https://raw.githubusercontent.com/KDE/plasma-workspace-wallpapers/master/Waterfall/contents/images/5120x2880.png";
          hash = "sha256-R3N/l3E3/h9K762/m79rM/C0E9p34024N6r6X1k6m04="; # Reemplazar con el hash correcto si difiere
        }
    );

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
