{ lib, pkgs, ... }:

{
  boot.isContainer = lib.mkForce true;

  boot.loader.initScript.enable = lib.mkForce false;

  boot.loader.grub.enable = lib.mkForce false;

  boot.loader.systemd-boot.enable = lib.mkForce false;

  # already run in container, kernel sandboxing not available
  nix.settings.sandbox = lib.mkForce false;

  # Disable specialfs activation script, since running as systemd-nspawn container
  system.activationScripts.specialfs = lib.mkForce "";

  # Do not use host resolv.conf
  networking.useHostResolvConf = lib.mkForce false;

  console.enable = lib.mkForce true;

  # Container should not set timezone,always follow host timezone
  time.timeZone = lib.mkForce null;

  environment.systemPackages = with pkgs; [
    iptables
    mc
    ripgrep # recursively searches directories for a regex pattern
    jq      # A lightweight and flexible command-line JSON processor
    yq-go   # yaml processor https://github.com/mikefarah/yq
    eza     # A modern replacement for ‘ls’
    fzf     # A command-line fuzzy finder
    file
    which
    tree
    zip
    xz
    unzip
    openssl
    dig
    inetutils
    nixos-firewall-tool
    unixtools.net-tools
  ];
}
