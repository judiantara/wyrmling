{hostname, inputs, outputs, lib, config, pkgs, ...}:
{
  services.displayManager = {
    defaultSession = "plasma";
    
    sddm = {
      enable = true;
      wayland = {
        enable = true;
      };
    };
  };

  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
