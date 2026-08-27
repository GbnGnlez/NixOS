{ ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config.input = {
      "type:touchpad" = {
        # Enables or disables tap for specified input device.
        tap = "enabled";
        # Enables or disables natural (inverted) scrolling for the specified input device.
        natural_scroll = "enabled";
        # Enables or disables disable-while-typing for the specified input device.
        dwt = "enabled";
      };
    };
  };
}
