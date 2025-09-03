{ user, ... }:

{
  services.redis.servers.${user} = {
    enable     = true;
    user       = "${user}";
    group      = "${user}";
    port       = 6379;
    bind       = "127.0.0.1";
  };
}
