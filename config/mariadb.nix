{ user, pkgs, ... }:
{
  services.mysql = {
    enable   = true;
    package  = pkgs.mariadb;
    user     = "${user}";
    group    = "${user}";
    settings = {
      mysqld = {
        skip-networking = true;
        max_allowed_packet = "500M";
      };
    };
    ensureUsers = [
      {
        name = "${user}";
        ensurePermissions = {
          "*.*" = "ALL PRIVILEGES";
        };
      }
    ];
  };
}
