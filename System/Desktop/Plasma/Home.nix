{
  pkgs,
  DarkTheme ? false,
  Color,
  ...
}:

{
  imports = [
    ./KScreenLocker.nix
    ./Panels.nix
    ./Fonts.nix
  ];

  # Set resolution to 1280x720 automatically upon graphical session startup
  # systemd.user.services.set-display-resolution = {
  # Unit = {
  # Description = "Set KDE display resolution to 1280x720";
  # After = [ "graphical-session.target" ];
  # PartOf = [ "graphical-session.target" ];
  # };
  # Install = {
  # WantedBy = [ "graphical-session.target" ];
  # };
  # Service = {
  # Type = "oneshot";
  # ExecStart = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.eDP-1.mode.1280x720@60";
  # };
  # };

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
      lookAndFeel = if DarkTheme then "org.kde.breezedark.desktop" else "org.kde.breeze.desktop";
      iconTheme = if DarkTheme then "Papirus-Dark" else "Papirus-Light";

      cursor = {
        theme = if DarkTheme then "Bibata-Modern-Ice" else "Bibata-Modern-Classic";
        size = 16;
      };
    };

    configFile."kdeglobals"."General"."AccentColor" =
      if Color == "blue" then "61,174,233" else "233,58,154";
    configFile."kdeglobals"."General"."LastUsedCustomAccentColor" =
      if Color == "blue" then "61,174,233" else "233,58,154";
    configFile."kdeglobals"."Sounds"."Theme" = "freedesktop";
    configFile."ksplashrc"."KSplash"."Theme" = "None";
  };
}
