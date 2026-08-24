{
  pkgs,
  IconVariant ? "Light",
  CursorVariant ? "Classic",
  CursorSize ? 16,
  AccentColor ? "233,58,154",
  LookAndFeel ? "",
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./Plasma/KScreenLocker.nix
    ./Plasma/Panels.nix
    ./Plasma/Fonts.nix
  ];

  # Set resolution to 1280x720 automatically upon graphical session startup
  systemd.user.services.set-display-resolution = {
    Unit = {
      Description = "Set KDE display resolution to 1280x720";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.eDP-1.mode.1280x720@60";
    };
  };

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    # Night Color
    configFile."kwinrc"."NightColor"."Active" = true;
    configFile."kwinrc"."NightColor"."Mode" = "Location";
    configFile."kwinrc"."NightColor"."LocationMode" = "Automatic";
    configFile."kwinrc"."NightColor"."DayTemperature" = 6500;
    configFile."kwinrc"."NightColor"."NightTemperature" = 3750;

    workspace = {
      lookAndFeel = "org.kde.breeze" + LookAndFeel + ".desktop";
      iconTheme = "Papirus-" + IconVariant;

      cursor = {
        theme = "Bibata-Modern-" + CursorVariant;
        size = CursorSize;
      };
    };

    configFile."kdeglobals"."General"."AccentColor" = AccentColor;
    configFile."kdeglobals"."General"."LastUsedCustomAccentColor" = AccentColor;
    configFile."kdeglobals"."Sounds"."Theme" = "freedesktop";
    configFile."ksplashrc"."KSplash"."Theme" = "None";
  };
}
