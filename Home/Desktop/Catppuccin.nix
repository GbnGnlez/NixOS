# https://nix.catppuccin.com/options/main/home/catppuccin/

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
