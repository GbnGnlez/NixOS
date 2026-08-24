{ ... }:

{
  # Desktop Entries allow applications to be shown in your desktop environment's app launcher.
  xdg.desktopEntries = {
    "app-github" = {
      name = "GitHub";
      genericName = "Git repository hosting";
      comment = "Open GitHub as an application";
      exec = "firefox --start-maximized --app=https://github.com/";
      icon = "github";
      terminal = false;
      type = "Application";
      categories = [
        "Development"
        "Network"
        "Utility"
      ];
    };

    "app-mynixos" = {
      name = "MyNixOS";
      genericName = "NixOS package search";
      comment = "Open MyNixOS as an application";
      exec = "firefox --start-maximized --app=https://mynixos.com/";
      icon = "nix-snowflake";
      terminal = false;
      type = "Application";
      categories = [
        "Development"
        "Documentation"
        "Network"
      ];
    };

    "app-nixos-wiki" = {
      name = "NixOS Wiki";
      genericName = "NixOS documentation";
      comment = "Open NixOS Wiki as an application";
      exec = "firefox --start-maximized --app=https://wiki.nixos.org/wiki/NixOS_Wiki";
      icon = "nix-snowflake";
      terminal = false;
      type = "Application";
      categories = [
        "Development"
        "Documentation"
        "Network"
      ];
    };

    "app-notebooklm" = {
      name = "NotebookLM";
      genericName = "AI Research Assistant";
      comment = "Open NotebookLM as an application";
      exec = "firefox --start-maximized --app=https://notebooklm.google.com/";
      icon = "google";
      terminal = false;
      type = "Application";
      categories = [
        "Office"
        "Utility"
        "Network"
      ];
    };

    "app-youtube" = {
      name = "YouTube";
      genericName = "Video streaming service";
      comment = "Open YouTube as an application";
      exec = "firefox --start-maximized --app=https://www.youtube.com/";
      icon = "youtube";
      terminal = false;
      type = "Application";
      categories = [
        "AudioVideo"
        "Network"
      ];
    };
  };
}
