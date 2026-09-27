{ lib, ... }:

let
  hiddenApps = [
    "org.kde.kdeconnect.nonplasma.desktop" # KDE Connect Indicator
    "org.kde.kdeconnect.sms.desktop" # KDE Connect SMS
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
  # En Home Manager el módulo es services.kdeconnect
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  # Oculta exclusivamente SMS e Indicator del menú de aplicaciones (Fuzzel)
  xdg.desktopEntries = builtins.listToAttrs (map hideEntry hiddenApps);
}
