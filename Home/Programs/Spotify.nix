# https://wiki.nixos.org/wiki/Spotify

{ pkgs, ... }:

{
  # The set of packages that appear in /run/current-system/sw.
  environment.systemPackages = with pkgs; [
    spotify # Play music from the Spotify music service.
  ];

  networking.firewall.allowedTCPPorts = [ 57621 ]; # List of TCP ports on which incoming connections are accepted.
  networking.firewall.allowedUDPPorts = [ 5353 ]; # List of open UDP ports.
}
