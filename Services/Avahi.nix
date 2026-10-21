{ ... }:

{
  services.openssh.enable = true; # Whether to enable the OpenSSH secure shell daemon, which allows secure remote logins.

  services.avahi = {
    enable = true; # Whether to run the Avahi daemon, which allows Avahi clients to use Avahi's service discovery facilities and also allows the local machine to advertise its presence and services (through the mDNS responder implemented by avahi-daemon).
    nssmdns4 = true; # Whether to enable the mDNS NSS (Name Service Switch) plug-in for IPv4.
    nssmdns6 = true; # Whether to enable the mDNS NSS (Name Service Switch) plug-in for IPv6.
    openFirewall = true; # Whether to open the firewall for UDP port 5353.

    settings.publish = {
      publish-workstation = true; # Replaces publish.workstation
      publish-addresses = true; # Replaces publish.addresses
      "disable-publishing" = false; # Replaces publish.enable = true
    };
  };

  systemd.services.avahi-daemon = {
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
  };
}
