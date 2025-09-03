{ lib, ... }:

{
  # Enable systemd-networkd for systemd-nspawn container private networking
  systemd.network = {
    enable = lib.mkForce true;
    wait-online.enable = lib.mkForce false;
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce true;

  networking = {
    # Enable NetworkManager for manage networking via GUI
    networkmanager = {
      enable = lib.mkForce true;

      # ignore systemd-nspawn container interfaces
      unmanaged = [
        "interface-name:vb-*"
        "interface-name:ve-*"
        "interface-name:vz-*"
      ];
    };

    # Allow systemd-nspawn container reach the Internet
    nat = {
      enable = true;
      internalInterfaces = [
        "vb-+"
        "ve-+"
        "vz-+"
      ];
    };

    # Allow DHCP client request from systemd-nspawn container
    firewall.interfaces."vb-+".allowedUDPPorts = [ 53 67 ];
    firewall.interfaces."ve-+".allowedUDPPorts = [ 53 67 ];
    firewall.interfaces."vz-+".allowedUDPPorts = [ 53 67 ];

    # Enable firewall.
    firewall.enable = lib.mkForce true;

    # Disable IPv6
    enableIPv6 = lib.mkForce false;

    extraHosts = ''
      10.0.0.10 hasufel.opik
      10.0.0.20 windfola.opik
      10.0.0.30 shadowfax.opik
    '';
  };
}
