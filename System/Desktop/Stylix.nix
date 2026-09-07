{
  pkgs,
  DarkTheme,
  Color,
  ...
}:

let
  IconThemeName = if DarkTheme then "Papirus-Dark" else "Papirus-Light";
  Papirus = pkgs.papirus-icon-theme.override {
    color = Color;
  };
in

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

    fonts = {
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      serif = {
        package = pkgs.inter;
        name = "Inter";
      };

      # Set a dedicated monospace font to prevent pulling DejaVu Sans Mono
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
        applications = 11;
        terminal = 11;
        popups = 10;
      };
    };
  };

  environment.systemPackages = [
    Papirus
  ];

  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-icon-theme-name=${IconThemeName}
  '';

  environment.etc."xdg/gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-icon-theme-name=${IconThemeName}
  '';
}
