# https://wiki.nixos.org/wiki/Sway#Screenshots

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    grim
    slurp
    sway-contrib.grimshot
  ];
}
