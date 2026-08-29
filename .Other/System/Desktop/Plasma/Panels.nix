# https://github.com/nix-community/plasma-manager/blob/trunk/modules/panels.nix
# https://github.com/nix-community/plasma-manager/blob/trunk/modules/widgets/system-tray.nix\

{ ... }:

{
  programs.plasma.panels = [
    {
      height = 44; # The height of the panel.
      lengthMode = "fill"; # The length mode of the panel.
      location = "bottom"; # The location of the panel.
      alignment = "center"; # The alignment of the panel.
      hiding = "dodgewindows"; # The hiding mode of the panel.
      floating = true; # Floating style.

      # The widgets to use in the panel.
      widgets = [
        "org.kde.plasma.kickoff" # Kickoff is the default application launcher of the Plasma desktop.
        "org.kde.plasma.icontasks" # Icons Only Task Manager shows tasks only by their icon and not by icon and title of the window opened.
        "org.kde.plasma.marginsseparator"
        {
          # A system tray of other widgets/plasmoids
          systemTray = {
            icons = {
              scaleToFit = true; # Whether to automatically scale System Tray icons to fix the available thickness of the panel.
            };
          };
        }
        "org.kde.plasma.digitalclock" # A digital clock widget.
      ];
    }
  ];
}
