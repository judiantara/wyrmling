# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ user, ... }:

{
  wsl = {
    enable = true;
    defaultUser = "${user}";
    usbip.enable = true;
  };
}
