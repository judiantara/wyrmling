{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rage
  ];

  age = {
    ageBin = "${pkgs.rage}/bin/rage";
    identityPaths = [
      "/nix/persist/etc/ssh/ssh_host_ed25519_key" # prevent warning unable decrypt during install
    ];
  };
}
