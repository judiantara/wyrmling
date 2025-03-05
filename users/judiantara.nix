{ config, pkgs, lib, ... }:

{
  users.groups.judiantara = {
    gid = 1000;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.judiantara = {
    hashedPassword = "*";
    isNormalUser = true;
    description = "Baju Judiantara";
    home = "/home/judiantara";
    createHome = true;
    group = "judiantara";
    uid = 1000;
    extraGroups = [
      "wheel"
      "systemd-journal"
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK6G07AT9uNhUY7adp58KvhKfWajWOJNLIArqOfzlxG5 Baju Judiantara"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIMPE5alD1Q4iICcUg3Wl7s041izdVSYmDCJqBZiPzO4RAAAABHNzaDo= Baju Judiantara YubiKey"
    ];
  };

  security.sudo.extraRules= [
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
  
  # Enable automatic login for the user.
  services.displayManager = {
    defaultSession = "plasma";
    
    autoLogin = {
      enable = true;
      user = "judiantara";
    };
    
    sddm = {
      autoLogin = {
        relogin = true;
        minimumUid = 1000;
      };
    };
  };
}
