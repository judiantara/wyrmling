{ ... }:

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

#     extraConfig.pipewire-pulse."30-network-discover" = {
#       "pulse.cmd" = [
#         { cmd = "load-module"; args = "module-zeroconf-discover"; }
#       ];
#     };
  };
}
