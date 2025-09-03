{ lib, ... }:

{
  console.enable = lib.mkForce false;

  systemd.services = {
    "getty@".enable = lib.mkForce false;
    "autovt@".enable = lib.mkForce false;
    "serial-getty@".enable = lib.mkForce false;
  };
}
