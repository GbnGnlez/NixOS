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
  };
}
