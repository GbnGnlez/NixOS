# https://github.com/nix-community/plasma-manager/blob/trunk/modules/fonts.nix

{ ... }:

{
  programs.plasma.fonts = {
    general = {
      family = "Inter"; # The font family of this font.
      pointSize = 10; # The point size of this font.
    }; # The main font for the Plasma desktop.

    fixedWidth = {
      family = "JetBrains Mono"; # The font family of this font.
      pointSize = 10; # The point size of this font.
    }; # The fixed width or monospace font for the Plasma desktop.

    small = {
      family = "Inter"; # The font family of this font.
      pointSize = 8; # The point size of this font.
    }; # The font used for very small text.

    toolbar = {
      family = "Inter"; # The font family of this font.
      pointSize = 10; # The point size of this font.
    }; # The font used for toolbars.

    menu = {
      family = "Inter"; # The font family of this font.
      pointSize = 10; # The point size of this font.
    }; # The font used for menus.

    windowTitle = {
      family = "Inter"; # The font family of this font.
      pointSize = 10; # The point size of this font.
    }; # The font used for window titles.
  };
}
