{ user, uid, ... }:
{ ... }:
{
  nix.settings.trusted-users = [
    "${user}"
  ];

  users.groups.${user} = {
    gid = uid;
  };

  users.users.${user} = {
    hashedPassword = "*";
    isNormalUser = true;
    home = "/home/${user}";
    createHome = true;
    group = "${user}";
    uid = uid;
    extraGroups = [
      "networkmanager"
      # for network scanner access
      "scanner"
      "lp"
    ];
  };
}
