{ user, lib, ... }:

{
  nix.settings.trusted-users = [
    "${user}"
  ];

  users.groups.${user} = {
    gid = 1000;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    hashedPassword = "*";
    isNormalUser = true;
    home = "/home/${user}";
    createHome = true;
    group = "${user}";
    uid = 1000;
    extraGroups = [
      "wheel"
      "systemd-journal"
      "networkmanager"
      "vboxusers"
      "kvm"
    ];
  };

  # use memory safe sudo implementation
  security = {
    sudo.enable = lib.mkForce false;
    sudo-rs = {
      enable = true;
      execWheelOnly = false;
      extraRules = [
        {
          users = [ "${user}" ];
          commands = [
            {
              command = "ALL" ;
              options= [ "NOPASSWD" ];
            }
          ];
        }
      ];
    };
  };
}
