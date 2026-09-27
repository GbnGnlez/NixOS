{ pkgs, ... }:

{
  home.packages = with pkgs; [
    celluloid # Reproductor multimedia (backend libmpv)
    loupe # Visor de imágenes oficial moderno de GNOME
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "video/*" = [ "io.github.celluloid_player.Celluloid.desktop" ];
      "audio/*" = [ "io.github.celluloid_player.Celluloid.desktop" ];
      "image/*" = [ "org.gnome.Loupe.desktop" ];
    };
  };

  home.stateVersion = "26.05";
}
