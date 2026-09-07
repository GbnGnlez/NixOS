# System/Desktop/Stylix.nix
{
  pkgs,
  DarkTheme,
  Color,
  ...
}:

let
  IconThemeName = if DarkTheme then "Papirus-Dark" else "Papirus-Light";
  GtkThemeName = if DarkTheme then "Breeze-Dark" else "Breeze";
  QtColorScheme = if DarkTheme then "BreezeDark" else "BreezeLight";
  KdeLookAndFeel = if DarkTheme then "org.kde.breezedark.desktop" else "org.kde.breeze.desktop";

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

  # 1. System packages required for Breeze and custom Papirus rendering
  environment.systemPackages = [
    Papirus
    pkgs.kdePackages.breeze
    pkgs.kdePackages.breeze-gtk
  ];

  # 2. Qt Platform & Widget Style
  qt = {
    enable = true;
    platformTheme = "kde";
    style = "breeze";
  };

  # 3. Qt color scheme, icons, and look-and-feel injection
  environment.etc."xdg/kdeglobals".text = ''
    [General]
    ColorScheme=${QtColorScheme}

    [Icons]
    Theme=${IconThemeName}

    [KDE]
    LookAndFeelPackage=${KdeLookAndFeel}
  '';

  # 4. GTK 3 & GTK 4 declarative theme and icon configuration
  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=${GtkThemeName}
    gtk-icon-theme-name=${IconThemeName}
  '';

  environment.etc."xdg/gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=${GtkThemeName}
    gtk-icon-theme-name=${IconThemeName}
  '';

  # 5. Environment variable fallback for hardcoded GTK applications
  environment.sessionVariables = {
    GTK_THEME = GtkThemeName;
  };
}
