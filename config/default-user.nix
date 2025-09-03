{ user, uid, ... }:

{
  nix.settings.trusted-users = [
    "${user}"
  ];

  users.groups.${user} = {
    gid = uid;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    hashedPassword = "*";
    isNormalUser = true;
    home = "/home/${user}";
    createHome = true;
    group = "${user}";
    uid = uid;
    extraGroups = [
      "networkmanager"
    ];
  };
}
