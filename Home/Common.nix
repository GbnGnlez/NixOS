{ pkgs, lib, ... }:

let
  hiddenApps = [
    "org.gnome.Loupe.desktop" # Image Viewer[span_8](start_span)[span_8](end_span)
    "io.github.celluloid_player.Celluloid.desktop" # Celluloid[span_5](start_span)[span_5](end_span)

    # Gestores de archivos y escáner
    #"org.gnome.Nautilus.desktop" # Files[span_9](start_span)[span_9](end_span)
    #"org.kde.skanpage.desktop" # Skanpage[span_10](start_span)[span_10](end_span)

    # KDE Connect y sus módulos
    #"org.kde.kdeconnect.app.desktop" # KDE Connect[span_11](start_span)[span_11](end_span)
    #"org.kde.kdeconnect.nonplasma.desktop" # KDE Connect Indicator[span_12](start_span)[span_12](end_span)
    #"org.kde.kdeconnect.sms.desktop" # KDE Connect SMS[span_13](start_span)[span_13](end_span)
    #"org.kde.kdeconnect.daemon.desktop"
    #"org.kde.kdeconnect_open.desktop"

    # Herramientas del sistema y configuración
    "uuctl.desktop" # uuctl[span_14](start_span)[span_14](end_span)
    #"org.kde.kpmcore.desktop" # KDE Partition Manager[span_15](start_span)[span_15](end_span)
    #"org.kde.partitionmanager.desktop" # KDE Partition Manager (ID alternativo)[span_16](start_span)[span_16](end_span)
    #"cups.desktop" # Manage Printing[span_17](start_span)[span_17](end_span)
    #"system-config-printer.desktop" # Manage Printing (ID alternativo)[span_18](start_span)[span_18](end_span)
    #"nixos-manual.desktop" # NixOS Manual[span_19](start_span)[span_19](end_span)
    "nm-connection-editor.desktop" # Advanced Network Configuration[span_20](start_span)[span_20](end_span)
    "qt5ct.desktop" # Qt5 Settings[span_21](start_span)[span_21](end_span)
    "qt6ct.desktop" # Qt6 Settings[span_22](start_span)[span_22](end_span)
    "kvantummanager.desktop" # Kvantum Manager[span_23](start_span)[span_23](end_span)
  ];

  hideEntry = name: {
    name = lib.strings.removeSuffix ".desktop" name;
    value = {
      name = lib.strings.removeSuffix ".desktop" name;
      settings = {
        NoDisplay = "true";
      };
    };
  };
in

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

  xdg.desktopEntries = builtins.listToAttrs (map hideEntry hiddenApps);

  home.stateVersion = "26.05";
}
