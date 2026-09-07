# System/Desktop/Stylix.nix (o dentro de configuration.nix)

{
  pkgs,
  DarkTheme ? true,
  ...
}:

{
  stylix = {
    enable = true;
    polarity = if DarkTheme then "dark" else "light";

    base16Scheme =
      if DarkTheme then
        "${pkgs.base16-schemes}/share/themes/default-dark.yaml"
      else
        "${pkgs.base16-schemes}/share/themes/default-light.yaml";

    cursor = {
      package = pkgs.bibata-cursors;
      name = if DarkTheme then "Bibata-Modern-Ice" else "Bibata-Modern-Classic";
      size = 24;
    };
  };
}
