# https://wiki.nixos.org/wiki/Firefox

{ pkgs, DarkTheme, ... }:

{
  stylix.targets.firefox.profileNames = [ "NixOS" ];

  programs.firefox = {
    enable = true;

    profiles.NixOS = {
      #      id = 0;
      name = "NixOS";
      #      isDefault = true;

      extensions = {
        packages =
          with pkgs.nur.repos.rycee.firefox-addons;
          [
            ublock-origin
            #sponsorblock
          ]
          ++ pkgs.lib.optional DarkTheme darkreader;
      };

      settings = {
        "extensions.autoDisableScopes" = 0;
      };

      #      settings = {
      #        # --- Startup & Search ---
      #        "browser.startup.homepage" = "about:home";
      #        "browser.search.suggest.enabled" = false;
      #        "browser.urlbar.suggest.searches" = false;
      #
      #        # --- Telemetry, Diagnostics & Privacy ---
      #        "telemetry.archive.enabled" = false;
      #        "datareporting.healthreport.uploadEnabled" = false;
      #        "toolkit.telemetry.unified" = false;
      #        "browser.send_pings" = false;
      #        "browser.ping-centre.telemetry" = false;
      #        "breakpad.reportURL" = "";
      #
      #        # --- Hardware Acceleration & Rendering (VA-API / WebRender) ---
      #        "gfx.webrender.all" = true;
      #        "media.ffmpeg.vaapi.enabled" = true;
      #        "media.hardware-video-decoding.force-enabled" = true;
      #
      # --- Memory & Resource Management ---
      #        "browser.tabs.unloadOnLowMemory" = true;
      #      };
    };

    #    policies = {
    #      DisableTelemetry = true;
    #      DisablePocket = true;
    #      DisableFirefoxAccounts = false;
    #      DisableFirefoxStudies = true;
    #      DisableFeedbackCommands = true;
    #    };
  };

  # Set Firefox as the default handler for web URLs and MIME types
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "x-scheme-handler/*" = "firefox.desktop";
    };
  };
}
