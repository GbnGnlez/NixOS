{
  pkgs,
  Theme,
  Color,
  ...
}:

# let
#   Papirus-Icon-Theme-Custom = pkgs.papirus-icon-theme.overrideAttrs (oldAttrs: {
#     dontFixup = true;
#     nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.papirus-folders ];
#     postInstall = (oldAttrs.postInstall or "") + ''
#       export XDG_DATA_HOME="$out/share"
#       papirus-folders -o -C ${
#         if Color == "Pink" then
#           "pink"
#         else if Color == "Blue" then
#           "blue"
#         else
#           "pink"
#       } -t Papirus-${
#         if Theme == "Light" then
#           "Light"
#         else if Theme == "Dark" then
#           "Dark"
#         else
#           "Dark"
#       }
#     '';
#   });
# in

{
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    bibata-cursors
    inter
    papirus-icon-theme
    jetbrains-mono
    papirus-folders
    # Papirus-Icon-Theme-Custom
    glib
  ];

  # Configuración del Cursor (Global para GTK y X11)
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    name =
      if Theme == "Light" then
        "Bibata-Modern-Classic"
      else if Theme == "Dark" then
        "Bibata-Modern-Ice"
      else
        "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 16;
  };

  gtk = {
    enable = true;

    theme = {
      name =
        if Theme == "Light" then
          "Breeze"
        else if Theme == "Dark" then
          "Breeze-Dark"
        else
          "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };

    iconTheme = {
      name =
        if Theme == "Light" then
          "Papirus-Light"
        else if Theme == "Dark" then
          "Papirus-Dark"
        else
          "Papirus-Dark";

      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "Inter";
      size = 10;
      package = pkgs.inter;
    };
  };
}
