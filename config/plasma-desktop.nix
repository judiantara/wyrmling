{ user, uid, ... }:

{
  services.displayManager = {
    defaultSession = "plasma";
    
    autoLogin = {
      enable = true;
      user = "${user}";
    };

    sddm = {
      enable = true;
      autoNumlock = false;
      wayland = {
        enable = true;
      };
      autoLogin = {
        relogin = true;
        minimumUid = uid;
      };
      settings = {
        Users = {
          MinimumUid = uid;
        };
      };
    };
  };

  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  environment.etc."AccountsService/AccountsService.conf".text = ''
    [UserList]
    MinimumUid=${toString uid}
  '';

  services.accounts-daemon.enable = true;
}
