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
    # brave-origin
    wget
    file-roller
    fastfetch

    # Scanner tools
    sane-backends

    # Scanner GUI
    kdePackages.skanpage

    # KDE applications
    kdePackages.kolourpaint
    kdePackages.partitionmanager
  ];

  programs.nix-ld.enable = true;
}
