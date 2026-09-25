{ pkgs, ... }:

{
  imports = [
    ./WayBar.nix
  ];

  # Bash auto-launcher using UWSM
  programs.bash = {
    enable = true;
    profileExtra = ''
      if uwsm check may-start; then
        exec uwsm start hyprland.desktop
      fi
    '';
  };

  # Terminal
  programs.kitty.enable = true;

  # Menú de aplicaciones gestionado con módulo para que Stylix aplique temas y fuentes automáticamente
  programs.rofi.enable = true;

  home.packages = with pkgs; [
    hyprlock
    # hyprlauncher # Reemplazado por programs.rofi (rofi-wayland)
    # kdePackages.dolphin # Reemplazado por Thunar
    thunar
    thunar-archive-plugin # Integración para descomprimir/comprimir archivos
    thunar-volman # Gestión de volúmenes y discos extraíbles
    file-roller # Gestor de compresión compatible con Thunar
    brightnessctl
    wireplumber
    playerctl
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    configType = "hyprlang";

    settings = {
      # Monitor
      monitor = ",preferred,auto,1";

      # Programs & Modifiers
      # Se antepone 'uwsm app --' para que las aplicaciones abran dentro del entorno systemd de UWSM
      "$terminal" = "uwsm app -- kitty";
      # "$terminal" = "kitty";
      "$fileManager" = "uwsm app -- thunar";
      # "$fileManager" = "dolphin";
      # "$menu" = "uwsm app -- hyprlauncher"; # Reemplazado por rofi-wayland
      # "$menu" = "hyprlauncher";
      "$menu" = "uwsm app -- rofi -show drun -show-icons";
      "$mainMod" = "SUPER";

      # Autostart
      exec-once = [
        "uwsm app -- waybar"
      ];

      # Look and Feel
      # Note: col.active_border and col.inactive_border are omitted so Stylix manages theme colors.
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          # ERROR NIX: Choca con Stylix porque ya define un shadow.color calculado de tu paleta base16
          # color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      # Animations
      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint, 0.23, 1, 0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear, 0, 0, 1, 1"
          "almostLinear, 0.5, 0.5, 0.75, 1"
          "quick, 0.15, 0, 0.1, 1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
          "zoomFactor, 1, 7, quick"
        ];
      };

      # Layouts
      dwindle = {
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      scrolling = {
        fullscreen_on_one_column = true;
      };

      # Misc
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      # Input
      input = {
        kb_layout = "us";
        kb_variant = "colemak_dh";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = false;
        };
      };

      # ERROR HYPRLAND: 'workspace_swipe' y 'workspace_swipe_fingers' no existen en la sintaxis actual
      # gestures = {
      #   workspace_swipe = true;
      #   workspace_swipe_fingers = 3;
      # };

      # Per-device configurations
      device = [
        {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        }
      ];

      # Keybindings
      bind = [
        # Atajo añadido para abrir terminal también con Super + Enter
        "$mainMod, Return, exec, $terminal"
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
        # Con UWSM la salida limpia se hace con: "$mainMod, M, exec, uwsm stop"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod, Space, exec, $menu"
        "$mainMod, P, pseudo,"
        # ERROR HYPRLAND: 'togglesplit' no es un dispatcher suelto; se invoca con layoutmsg
        # "$mainMod, J, togglesplit,"
        "$mainMod, J, layoutmsg, togglesplit"

        # Move focus
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces 1-10
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to workspace 1-10
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      # Hardware keys (Volume & Brightness) with repeat and lock
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      # Media keys
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # Window manipulation with mouse
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
