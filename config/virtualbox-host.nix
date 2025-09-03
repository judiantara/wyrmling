{  ... }:

{
  virtualisation.virtualbox.host = {
    enable = true;
    enableKvm = true;
    addNetworkInterface = false;
  };

  # Open port for guest port-forwarding
  networking.firewall.allowedTCPPorts = [ 
    2222
  ];
}
