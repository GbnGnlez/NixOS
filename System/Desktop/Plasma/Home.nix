{
  pkgs,
  DarkTheme,
  Color,
  ...
}:

{
  imports = [
    ./KScreenLocker.nix
    ./Panels.nix
  ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    # Night Color
    configFile."kwinrc"."NightColor"."Active" = true;
    configFile."kwinrc"."NightColor"."Mode" = "Location";
    configFile."kwinrc"."NightColor"."LocationMode" = "Automatic";
    configFile."kwinrc"."NightColor"."DayTemperature" = 6500;
    configFile."kwinrc"."NightColor"."NightTemperature" = 3750;

    configFile."ksplashrc"."KSplash"."Theme" = "None";
  };
}
