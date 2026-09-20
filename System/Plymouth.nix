# https://wiki.nixos.org/wiki/Plymouth

{ GPU, ... }:

{
  boot = {
    # plymouth.enable = true;
    consoleLogLevel = 3;
    loader.timeout = 0;

    initrd = {
      verbose = false;
      kernelModules = [ GPU ];
    };

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
