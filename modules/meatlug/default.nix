{ user, lib, ... }:

{
  imports = [
    ../../hardware/cpu-amd.nix
    ../../hardware/sane.nix
    ../../hardware/printers.nix
    ../../hardware/keyboard.nix
    ../../hardware/bluetooth.nix
    ../../hardware/tlp.nix
    ../../config/bootloader.nix
    ../../config/system.nix
    ../../config/systemd-resolved.nix
    ../../config/network-extrahosts.nix
    ../../config/system-packages.nix
    ../../config/console-disabled.nix
    ../../config/plasma-desktop.nix
    ../../config/zsh.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/ca-certificates.nix
    ../../config/pipewire-audio.nix
    ../../config/yubikey.nix
    ../../config/age-encryption.nix
    ../../config/kdeconnect.nix
    ../../config/syncthing.nix
    ../../config/git.nix
    ../../config/flatpak.nix
    ../../config/podman.nix
    ../../users/${user}
    ../workhorses
    ./networking.nix
    ./disk.nix
    ./luks.nix
  ];

  # Install mikrotik winbox using flatpak
  # Open udp port for mikrotik device discovery
  networking.firewall = {
    allowedUDPPorts = [ 5678 ];
  };

  services.pipewire = {
    extraConfig.pipewire-pulse."30-network-discover" = {
      "pulse.cmd" = [
        { cmd = "load-module"; args = "module-zeroconf-discover"; }
      ];
    };
  };

  boot.loader.systemd-boot.consoleMode = lib.mkForce "0";
}
