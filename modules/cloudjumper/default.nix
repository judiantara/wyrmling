{ user, lib, ... }:

{
  imports = [
    ../../hardware/cpu-amd.nix
    ../../hardware/sane.nix
    ../../hardware/printers.nix
    ../../hardware/keyboard.nix
    ../../config/bootloader.nix
    ../../config/system.nix
    ../../config/system-packages.nix
    ../../config/zram-swap.nix
    ../../config/console-disabled.nix
    ../../config/sleep-disabled.nix
    ../../config/plasma-desktop.nix
    ../../config/networkmanager.nix
    ../../config/systemd-resolved.nix
    ../../config/avahi-mdns.nix
    ../../config/network-extrahosts.nix
    ../../config/zsh.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/ca-certificates.nix
    ../../config/pipewire-audio.nix
    ../../config/age-encryption.nix
    ../../config/kdeconnect.nix
    ../../config/syncthing.nix
    ../../config/git.nix
    ../../config/flatpak.nix
    ../../users/${user}
    ./disk.nix
    ./luks.nix
  ];

  boot.blacklistedKernelModules = [
    "snd_hda_codec_hdmi"
    "snd_hda_codec_atihdmi"
  ];

  services.pipewire = {
    extraConfig.pipewire-pulse."30-network-discover" = {
      "pulse.cmd" = [
        { cmd = "load-module"; args = "module-zeroconf-discover"; }
      ];
    };
  };

  # Install mikrotik winbox using flatpak
  # Accept udp packet from mikrotik router sent from MAC-Winbox port
  networking.firewall.extraCommands = lib.concatLines [
    "iptables -A nixos-fw -p udp -m udp --dport 5678  -j nixos-fw-accept"
    "iptables -A nixos-fw -p udp -m udp --sport 20561 -j nixos-fw-accept"
  ];
}
