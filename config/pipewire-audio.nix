{hostname, inputs, outputs, lib, config, pkgs, ...}:
{
  # Enable sound with pipewire.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;

    extraConfig.pipewire-pulse."30-network-discover" = {
      "pulse.cmd" = [
        { cmd = "load-module"; args = "module-zeroconf-discover"; }
      ];
    };
  };

  # Enable avahi for mdns service discovery
  services.avahi = {
    enable = lib.mkForce true;
    openFirewall = lib.mkForce true;
    publish = {
      enable       = true;
      addresses    = true;
      domain       = true;
      userServices = true;
      workstation  = true;
    };
  };
}
