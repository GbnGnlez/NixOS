{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    grim
    slurp
    sway-contrib.grimshot
  ];
}
