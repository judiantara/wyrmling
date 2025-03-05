{hostname, inputs, outputs, lib, config, pkgs, ...}:
{
  # Enable virtualbox guest module for this vm
  virtualisation.virtualbox.guest.enable = true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  
  networking = {
    hostName = "${hostname}";
    useDHCP = lib.mkForce true;
    
    # use network manager
    networkmanager.enable = lib.mkForce true;

    # firewall.
    firewall.enable = lib.mkForce false;
  };

  services.resolved = {
    enable = lib.mkForce true;
    domains     = [ "~." ];
    fallbackDns = [
      "1.1.1.1"
      "8.8.4.4"
    ];
  };
  
  # Disable sound with pipewire.
  services.pipewire.enable = lib.mkForce false;
}
