{lib, config, pkgs, ...}:
{
  services.mysql = {
    enable   = true;
    package  = pkgs.mariadb;
    user     = "pemweb";
    group    = "pemweb";
    settings = {
      mysqld = {
        skip-networking = true;
        max_allowed_packet = "500M";
      };
    };
    ensureUsers = [
      {
        name = "pemweb";
        ensurePermissions = {
          "*.*" = "ALL PRIVILEGES";
        };
      }
    ];
    initialDatabases = [
      { name = "bantoo"; }
    ];
  };
}
