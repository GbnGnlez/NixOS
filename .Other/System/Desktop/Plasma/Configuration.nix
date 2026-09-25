# https://wiki.nixos.org/wiki/KDE

{ pkgs, ... }:

{
  services = {
    displayManager.plasma-login-manager.enable = true;
    desktopManager.plasma6.enable = true;
  };

  # https://github.com/NixOS/nixpkgs/blob/7e495b747b51f95ae15e74377c5ce1fe69c1765f/nixos/modules/services/desktop-managers/plasma6.nix#L150-L170
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover
    qrca

    # aurorae
    # plasma-browser-integration
    # plasma-workspace-wallpapers
    # konsole
    # kwin-x11
    # (lib.getBin qttools)
    # ark
    elisa
    # gwenview
    okular
    kate
    # ktexteditor
    khelpcenter
    # dolphin
    # baloo-widgets
    # dolphin-plugins
    # spectacle
    # ffmpegthumbs
    # krdp
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
