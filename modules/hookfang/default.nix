{ lib, ... }:

{
  imports = let
    deviceName = "Hookfang";
  in [
    ../../hardware/cpu-amd.nix
    ../../hardware/network-scanner.nix
    ../../hardware/network-printers.nix
    ../../hardware/keyboard.nix
    ../../hardware/bluetooth.nix
    ../../hardware/auto-cpufreq.nix
    ../../config/bootloader.nix
    ../../config/system.nix
    ../../config/systemd-resolved.nix
    ../../config/network-extrahosts.nix
    ../../config/system-packages.nix
#    ../../config/console-disabled.nix
    ../../config/sleep-disabled.nix
    ../../config/zram-swap.nix
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
    ../../users/judiantara
    ../workhorses
    ./networking.nix
    (import ../../config/disk/efi-luks-btrfs.nix { name = "${deviceName}"; device = "/dev/disk/by-id/ata-KYO_1TB_2025030400012522"; })
    (import ../../config/luks-device.nix         { name = "${deviceName}"; })
  ];

#   services.pipewire = {
#     extraConfig.pipewire-pulse."30-network-discover" = {
#       "pulse.cmd" = [
#         { cmd = "load-module"; args = "module-zeroconf-discover"; }
#       ];
#     };
#   };

  boot.loader.systemd-boot.consoleMode = lib.mkForce "0";
}
