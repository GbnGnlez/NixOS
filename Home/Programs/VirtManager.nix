# https://wiki.nixos.org/wiki/Virt-manager
# Virtualization.nix
# Configuración de QEMU/KVM con Virt-Manager para NixOS
# Importado desde configuration.nix

{ pkgs, ... }:

{
  programs.virt-manager.enable = true; # Whether to enable virt-manager, an UI for managing virtual machines in libvirt.

  # ---------------------------------------------------------------
  # Libvirtd: demonio que administra QEMU/KVM
  # ---------------------------------------------------------------
  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;

      # vTPM, necesario para instalar Windows 11 (requiere TPM 2.0)
      swtpm.enable = true;

      # Nota: a partir de NixOS 26.05 la submodule "ovmf" fue eliminada.
      # Las imágenes OVMF (soporte UEFI) ya vienen incluidas por defecto
      # con QEMU, no requieren configuración adicional.
    };
  };

  # Redirección de dispositivos USB del host hacia el guest vía SPICE
  virtualisation.spiceUSBRedirection.enable = true;

  # ---------------------------------------------------------------
  # Permisos de usuario
  # ---------------------------------------------------------------
  # IMPORTANTE: cambia "nixos" por tu nombre de usuario si es distinto
  users.groups.libvirtd.members = [ "nixos" ];
  users.users.nixos.extraGroups = [ "libvirtd" ];

  # ---------------------------------------------------------------
  # Paquetes adicionales
  # ---------------------------------------------------------------
  environment.systemPackages = with pkgs; [
    qemu # Generic and open source machine emulator and virtualizer.
    virt-manager # Desktop user interface for managing virtual machines.
    virt-viewer # Viewer for remote virtual machines.
    spice # Complete open source solution for interaction with virtualized desktop devices.
    spice-gtk # GTK 3 SPICE widget.
    spice-protocol # Protocol headers for the SPICE protocol.
  ];

  # ---------------------------------------------------------------
  # Autostart de la red virtual "default" (virbr0)
  # Equivalente declarativo a:
  #   virsh net-autostart default
  #   virsh net-start default
  # ---------------------------------------------------------------
  systemd.services.libvirtd-default-net-autostart = {
    description = "Autostart de la red 'default' de libvirt";
    after = [ "libvirtd.service" ];
    requires = [ "libvirtd.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.libvirt}/bin/virsh net-autostart default || true
      ${pkgs.libvirt}/bin/virsh net-start default || true
    '';
  };
}
