{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./Hardware.nix
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak_dh";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Scanner support
  hardware.sane.enable = true;

  # Define a user account.
  users.users."nixos" = {
    isNormalUser = true;
    description = "NixOS";
    extraGroups = [
      "scanner"
      "lp"
    ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    tree
    firefox
    wget

    # Scanner tools
    sane-backends
    usbutils

    # Scanner GUI
    kdePackages.skanpage

    # KDE applications
    kdePackages.konsole
    kdePackages.partitionmanager
  ];

  programs.kdeconnect.enable = true;

  programs.nix-ld.enable = true;
}
