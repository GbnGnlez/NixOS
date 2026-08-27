{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./Hardware.nix
  ];

  # List of default packages to exclude from the configuration.
  # environment.plasma6.excludePackages = with pkgs.kdePackages; [
  # okular # KDE document viewer.
  # ];

  # The set of packages that appear in /run/current-system/sw.
  environment.systemPackages = with pkgs; [
    tree # Command to produce a depth indented directory listing.
    # kdePackages.kolourpaint # Easy-to-use paint program.
    kdePackages.konsole # Terminal emulator by KDE.
    kdePackages.partitionmanager # Manage the disk devices, partitions and file systems on your computer.
    # kdePackagesskanpage # Utility to scan images and multi-page documents.
  ];

  programs.kdeconnect.enable = true; # Whether to enable kdeconnect.

  programs.nix-ld.enable = true; # Whether to enable nix-ld.
}
