# https://nix.catppuccin.com/options/main/nixos/catppuccin/

{
  Theme,
  Color,
  ...
}:

{
  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = Theme;
    accent = Color;
  };
}
