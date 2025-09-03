{ lib, ... }:

{
  # Use systemd-networkd to manage networking instead of NetworkManager
  systemd.network = {
    enable = lib.mkForce true;
    wait-online = {
      enable = lib.mkForce true;
      extraArgs = [
        "--any"
#         "--dns"
      ];
    };
  };

  networking = {
    # Disable NetworManager
    networkmanager.enable = lib.mkForce false;

    # Enable firewall.
    firewall.enable = lib.mkForce true;

    useDHCP = lib.mkForce false;

    useNetworkd = lib.mkForce true;

    # Disable IPv6
    enableIPv6 = lib.mkForce false;
  };
}
