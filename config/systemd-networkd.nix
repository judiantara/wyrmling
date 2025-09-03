{ lib, ... }:

{
  networking = {
    # Disable NetworManager
    networkmanager.enable = lib.mkForce false;

    # Disable dhcpcd
    useDHCP = lib.mkForce false;

    # Enable systemd-networkd
    useNetworkd = lib.mkForce true;

    # Enable firewall.
    firewall.enable = lib.mkForce true;

    # Disable IPv6
    enableIPv6 = lib.mkForce false;
  };

  # Use systemd-networkd to manage networking instead of NetworkManager
  systemd.network = {
    enable = lib.mkForce true;
    wait-online = {
      enable = lib.mkForce true;
      extraArgs = [
        "--any"
      ];
    };
  };

  # Enable systemd-resolved for DNS resolution
  services.resolved = {
    enable      = lib.mkForce true;
    domains     = lib.mkForce [ "~." ];
    dnssec      = lib.mkForce "false";
    dnsovertls  = lib.mkForce "false";
    fallbackDns = lib.mkForce [
      "1.1.1.3"
      "1.0.0.3"
    ];
  };
}
