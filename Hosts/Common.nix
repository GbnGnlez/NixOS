# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  ...
}:

{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    extra-substituters = [
      "https://gbngnlez.cachix.org"
    ];

    extra-trusted-public-keys = [
      "gbngnlez.cachix.org-1:4087tPR0DCehBmp1z8gmoRk91VcUOjmcV9KdKI64MOU="
    ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "NixOS"; # Define your hostname.
  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Mexico_City";

  # Select internationalisation properties.
  # i18n.defaultLocale = sysLocale;

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  # services.xserver.enable = true;

  # Which X11 packages to exclude from the default environment.
  services.xserver.excludePackages = with pkgs; [
    xterm # Terminal emulator for the X Window System.
  ];

  # Configure keymap in X11
  # services.xserver.xkb = {
  # layout = "";
  # variant = "";
  # };

  # If set, configure the virtual console keymap from the xserver keyboard settings.
  console.useXkbConfig = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."nixos" = {
    isNormalUser = true;
    description = "NixOS";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  security.sudo.wheelNeedsPassword = false; # Whether users of the wheel group must provide a password to run commands as super user via sudo.

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # These packages are automatically available to all users, and are automatically updated every time you rebuild the system configuration
  environment.systemPackages = with pkgs; [
    git # Distributed version control system.
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  # enable = true;
  # enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
