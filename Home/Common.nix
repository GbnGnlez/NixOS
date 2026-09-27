{ pkgs, ... }:

{
  home.packages = with pkgs; [
    loupe
    celluloid
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/*" = [ "org.gnome.Loupe.desktop" ];
      "audio/*" = [ "io.github.celluloid_player.Celluloid.desktop" ];
      "video/*" = [ "io.github.celluloid_player.Celluloid.desktop" ];
    };
  };

  home.stateVersion = "26.05";
}
