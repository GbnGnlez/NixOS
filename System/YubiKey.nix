{ pkgs, ... }:

{
  # Reglas Udev para la YubiKey
  services.udev.packages = [ pkgs.yubikey-personalization ];

  # Soporte para GPG y agentes SSH basados en hardware
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
