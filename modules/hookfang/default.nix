{ user, lib, ... }:

{
  imports = [
    ../../hardware/cpu-amd.nix
    ../../hardware/network-scanner.nix
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
    ../../config/git.nix
    ../../config/flatpak.nix
    ../../config/podman.nix
    ../../config/firewall/kdeconnect.nix
    ../../config/firewall/mac-winbox.nix
    ../../config/firewall/syncthing.nix
    ../../users/${user}
    ../workhorses
    ./networking.nix
    ./disk.nix
    ./luks.nix
  ];

  services.pipewire = {
    extraConfig.pipewire-pulse."30-network-discover" = {
      "pulse.cmd" = [
        { cmd = "load-module"; args = "module-zeroconf-discover"; }
      ];
    };
  };

  boot.loader.systemd-boot.consoleMode = lib.mkForce "0";
}
