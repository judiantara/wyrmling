{ pkgs, ... }:

let
  hasufel   = { MACAddress = "d6:41:e8:01:43:4d"; Address = "10.0.0.10"; };
  shadowfax = { MACAddress = "d6:41:e8:01:43:4e"; Address = "10.0.0.20"; };
  windfola  = { MACAddress = "d6:41:e8:01:43:4f"; Address = "10.0.0.30"; };
in
{
  # Use systemd-nspawn zone nettworking, it will auto create vritual bridge
  # Set workhorses zone dhcp server
  # Beware on naming, follow systemd precedence rule
  systemd.network.networks."00-bridge-vz-workhorses" = {
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

    dhcpServerConfig = {
      DNS           = "10.0.0.1";
      EmitDNS       = "yes";
      PoolSize      =  20;
      PoolOffset    = 100;
      PersistLeases = "no";
    };

    dhcpServerStaticLeases = [
      hasufel
      shadowfax
      windfola
    ];
  };

  # setup workhorses zone dns server
  # redirect dns request to host systemd-resolved using socat
  # only start service when zone bridge device active
  environment.systemPackages = with pkgs; [
    socat
  ];

  # DNS service for zone workhorses, DNS request proxied to host's systemd-resolved
  systemd.services.vz-workhorses-dns = {
    description = "DNS Server for vz-workhorses zone";
    unitConfig = {
      # Only start if virtual bridge device exist
      ConditionDirectoryNotEmpty = "|/sys/devices/virtual/net/vz-workhorses";

      # Shutdown if bridge device removed
      BindsTo = "sys-subsystem-net-devices-vz\\x2dworkhorses.device";

      # Run service after bridge device active
      After = "sys-subsystem-net-devices-vz\\x2dworkhorses.device";
    };

    serviceConfig = {
      Type           = "simple";
      StandardOutput = "journal";
      StandardError  = "journal";
      ExecStartPre   = "${pkgs.coreutils-full}/bin/sleep 2"; # Wait before start socat
      ExecStart      = "${pkgs.socat}/bin/socat -ls -4 udp4-listen:53,bind=10.0.0.1,reuseaddr,fork udp4-connect:127.0.0.53:53";

      RestartForceExitStatus = "143";
      SuccessExitStatus = "143";
    };
  };

  # start DNS service for zone workhorses only when workhorses bridge active
  # triggered using udev, since inotify does not support watching sysfs, hence cannot use systemd.path
  services.udev.extraRules = ''
    KERNEL=="vz-workhorses", SUBSYSTEM=="net", DRIVER=="", ACTION=="add", ENV{SYSTEMD_WANTS}="vz-workhorses-dns.service"
  '';
}
