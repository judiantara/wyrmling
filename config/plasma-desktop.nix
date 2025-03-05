{lib, config, pkgs, user, ...}:
{
  services.displayManager = {
    defaultSession = "plasma";
    
    autoLogin = {
      enable = true;
      user = "${user}";
    };

    sddm = {
      enable = true;
      wayland = {
        enable = true;
      };
      autoLogin = {
        relogin = true;
        minimumUid = 1000;
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
