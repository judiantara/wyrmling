{ lib, ... }:

{
  # Install mikrotik winbox using flatpak
  # Accept udp packet from mikrotik router sent from MAC-Winbox port
  networking.firewall.extraCommands = lib.concatLines [
    "iptables -A nixos-fw -p udp -m udp --dport 5678  -j nixos-fw-accept"
    "iptables -A nixos-fw -p udp -m udp --sport 20561 -j nixos-fw-accept"
  ];
}
