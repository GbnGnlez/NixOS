#https://github.com/Diolinux/Photogimp

{ pkgs, ... }:

let
  PhotoGIMP = pkgs.fetchzip {
    url = "https://github.com/Diolinux/PhotoGIMP/releases/download/3.0/PhotoGIMP-linux.zip";
    hash = "sha256-g7JNSr6LczV0uHvy5UjRwDwVkWTGMFRd0bW9RaBoDjM=";
  };
in

{
  # The set of packages to appear in the user environment.
  home.packages = with pkgs; [
    gimp # GNU Image Manipulation Program.
  ];

  # Attribute set of files to link into the user home.
  home.file.".config/GIMP/3.2" = {
    source = "${PhotoGIMP}/.config/GIMP/3.2"; # Path of the source file or directory.
    recursive = true; # If the file source is a directory, then this option determines whether the directory should be recursively linked to the target location.
  };
}
