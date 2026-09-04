# https://wiki.nixos.org/wiki/Plymouth

{
  GPU,
  ...
}:

{
  boot = {
    plymouth.enable = true; # Whether to enable Plymouth boot splash screen.
    consoleLogLevel = 3; # The kernel console loglevel.
    loader.timeout = 0; # Timeout (in seconds) until loader boots the default menu item.

    initrd = {
      verbose = false; # Verbosity of the initrd.
      kernelModules = [ GPU ]; # Set of modules that are always loaded by the initrd.
    };

    # Parameters added to the kernel command line.
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
      # "systemd.show_status=false"
      # "rd.udev.log_level=3"
      # "udev.log_priority=3"
    ];
  };
}
