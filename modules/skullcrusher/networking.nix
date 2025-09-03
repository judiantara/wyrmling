{ lib, ... }:

{
  # Enable systemd-networkd for microvm and systemd-nspawn container private networking
  systemd.network = {
    enable = lib.mkForce true;
    wait-online.enable = lib.mkForce false;
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce true;

  networking = {
    # Enable NetworkManager for manage networking via GUI
    networkmanager = {
      enable = lib.mkForce true;

      dns = "systemd-resolved";

      # ignore microvm and systemd-nspawn container interfaces
      unmanaged = [
        "interface-name:vb-*"
        "interface-name:ve-*"
        "interface-name:vz-*"
        "interface-name:vm-*"
      ];
    };

    # Allow microvm and systemd-nspawn container reach the Internet
    nat = {
      enable = true;
      internalInterfaces = [
        "vb-+"
        "ve-+"
        "vz-+"
        "vm-+"
        "microvm"
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
      10.0.1.10 hasufel.opik
      10.0.1.20 shadowfax.opik
      10.0.1.30 windfola.opik
      10.1.1.1  skullcrusher.devel
    '';

    nameservers = [
      "192.168.240.1"
    ];
  };

  systemd.network = {
    netdevs."10-microvm-host" = {
      netdevConfig = {
        Kind = "bridge";
        Name = "microvm";
      };
    };

    networks."10-microvm-host" = {
      matchConfig.Name = "microvm";
      networkConfig = {
        Address = "10.1.1.1/24"; # Host gateway IP for the VMs
        DHCPServer = false;
      };
    };

    # Automatically plug any microvm.nix TAP interface into this bridge
    networks."11-microvm-vm" = {
      matchConfig.Name = "vm-*";
      networkConfig = {
        Bridge = "microvm";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 5000 ];

  services.dnsmasq = {
    enable = true;
    settings = {
      listen-address = [ "127.0.0.2" ];
      bind-interfaces = true;
      address = [
        "/.m1.devel/192.168.100.10"
      ];
    };
  };

   # use dnsmasq to resolve *.devel domain
  environment.etc."systemd/resolved.conf.d/microvm.conf" = {
    text = ''
      [Resolve]
      DNS=127.0.0.2
      Domains=~devel
    '';
  };

  # do not autostart these microvms
  # use 'microvm.autostart = lib.attrNames vmsConfig;' if we want autostart it
  microvm.autostart = [];
}
