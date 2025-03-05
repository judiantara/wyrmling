{lib, config, pkgs, ...}:
{
  services.redis.servers.pemweb = {
    enable     = true;
    user       = "pemweb";
    group      = "pemweb";
#    port       = 6379;
#    bind       = "127.0.0.1";
  };
}
