{ pkgs, lib, ... }:

{
  imports = [
    ../../config/plasma-desktop.nix
    ../../config/default-user.nix
  ];

  programs.firefox = {
    enable = lib.mkForce true;
  };

  environment.systemPackages = with pkgs; [
    vlc
    ungoogled-chromium
    libreoffice-qt6-fresh
    kdePackages.elisa
    kdePackages.kcalc
    kdePackages.sddm-kcm
    kdePackages.spectacle
    kdePackages.kcharselect
    kdePackages.plasma-browser-integration
  ];

  users.users.iswarini.description = "Peni Iswarini";

  users.groups.judiantara = {
    gid = 1000;
  };

  users.users.judiantara = {
    hashedPassword = "*";
    isNormalUser = true;
    home = "/tmp";
    createHome = false;
    group = "judiantara";
    uid = 1000;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

 # use memory safe sudo implementation
  security = {
    sudo.enable = lib.mkForce false;
    sudo-rs = {
      enable = lib.mkForce true;
      execWheelOnly = lib.mkForce true;
      extraRules = [
        {
          users = [ "judiantara" ];
          commands = [
            {
              command = "ALL" ;
              options= [ "NOPASSWD" ];
            }
          ];
        }
      ];
    };
    pam = {
      services = {
        login.u2fAuth = true;
        sudo.u2fAuth = true;
      };
      u2f = {
        enable = true;
        settings = {
          interactive = true;
          cue = true;
          origin = "pam://judiantara";
          authfile = pkgs.writeText "u2f-mappings" (lib.concatStrings [
            "judiantara"
            ":6fEVt9/C594Ii7D7S/6JJifTsA0DrRjaZLuoJx2fknY0IvpQ9uOzHphw5dzCRVub/445uXM7+6RpSOJbb9vO5w==,vNeL2KR7vXjeHSOBTMZCuVRCjWM/AmOd9zXsFEHOKYhp6189sMK4klxQylvIIJCs3c8MYA97B2g1++jqcQS6cA==,es256,+presence"
            ":GzDTETgQ+4iNbu+KqGeTHM+7A4DDcfkbANMfCWc+0FvsGhZXV+9HPY/c4PgBKa8nQy4nCeXT0C+sW63vMvqcQw==,6Khxu5rkiDIIWkDB1tLE7bY4YeE+XLzKYVcI3H5TgX2ryrVVFCFW6taxjZ/A/IcawT2zpEV+2WD4iR6YQ2NeeQ==,es256,+presence"
          ]);
        };
      };
    };
    polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (
          action.id == "org.freedesktop.login1.lock-session"  ||
          action.id == "org.freedesktop.login1.lock-sessions" ||
          action.id == "org.freedesktop.login1.suspend"       ||
          action.id == "org.freedesktop.login1.hibernate"
        ) {
          return polkit.Result.NO;
        }
      });
    '';
  };

  environment.etc = {
    "xdg/kdeglobals".text = ''
      [KDE Control Module Restrictions][$i]
      kcm_users=false

      [KDE Action Restrictions][$i]
      action/lock_screen=false
      lock_screen=false
    '';

    "xdg/kscreenlockerrc".text = ''
      [Daemon]
      Autolock=false
      LockOnResume=false
      Timeout=0
    '';

  "xdg/kglobalshortcutsrc".text = ''
      [ksmserver]
      Lock Session=none,,Lock Session
    '';
  };
}
