{ pkgs, ... }:

{
  # eanble openvpn plugin
  networking.networkmanager.plugins = [ pkgs.networkmanager-openvpn ];
}
