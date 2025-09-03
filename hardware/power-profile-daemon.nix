{ lib, ... }:

{
  services.tlp.enable = lib.mkForce false;

  # disable power-profile-daemon
  services.power-profiles-daemon.enable = lib.mkForce true;
}
