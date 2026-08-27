# https://wiki.nixos.org/wiki/Sway#Brightness_and_volume

{ pkgs, ... }:

{
  users.users.nixos.extraGroups = [ "video" ];
  #programs.light.enable = true;
  environment.systemPackages = [ pkgs.pulseaudio ];
}
