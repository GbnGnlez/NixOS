{ pkgs, ... }:

{
  users.users.nixos.extraGroups = [ "video" ];
  #programs.light.enable = true;
  environment.systemPackages = [ pkgs.pulseaudio ];
}
