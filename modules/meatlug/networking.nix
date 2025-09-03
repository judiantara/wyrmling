{ lib, ... }:

{
  # Enable systemd-networkd for systemd-nspawn container private networking
  systemd.network.enable = lib.mkForce true;

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
        "ve-+"
        "vz-+"
      ];
    };

    # Allow DHCP client request from systemd-nspawn container
    firewall.interfaces."ve-+".allowedTCPPorts = [ 53 ];
    firewall.interfaces."ve-+".allowedUDPPorts = [ 53 67 ];
    firewall.interfaces."vz-+".allowedTCPPorts = [ 53 ];
    firewall.interfaces."vz-+".allowedUDPPorts = [ 53 67 ];

    # Enable firewall.
    firewall.enable = lib.mkForce true;

    # Disable IPv6
    enableIPv6 = lib.mkForce false;
  };

#    systemd.services.systemd-networkd.environment.SYSTEMD_LOG_LEVEL = "debug";

  # Beware on naming, since systemd precedence rule
  systemd.network.networks."00-bride-vz-workhorses" = {
    matchConfig = {
      Name = "vz-workhorses";
    };

    networkConfig = {
      Address             = "10.0.0.1/24";
      LinkLocalAddressing = "no";
      DHCPServer          = "yes";
      IPMasquerade        = "ipv4";
      LLDP                = "yes";
      EmitLLDP            = "customer-bridge";
      IPv6AcceptRA        = "no";
      IPv6SendRA          = "no";
    };

#     dhcpServerConfig = {
#       EmitDNS    = "yes";
#       PoolOffset = 100;
#       PoolSize   = 20;
#     };

#     dhcpServerStaticLeases = [
#       {
#         Address = "10.0.0.101";
#         MACAddress = "d6:41:e8:01:43:4e";
#       }
#     ];
  };
}
