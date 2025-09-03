{ lib, pkgs, ... }:

let
  bootScript = pkgs.writeScript "install-sbin-init.sh" ''
    #!${pkgs.runtimeShell}
    ${pkgs.coreutils}/bin/ln -sf "$1/init" /sbin/init
  '';
in
{
  boot.isContainer = lib.mkForce true;

  boot.loader.initScript.enable = lib.mkForce false;

  boot.loader.grub.enable = lib.mkForce false;

  boot.loader.systemd-boot.enable = lib.mkForce false;

  # already run in container, kernel sandboxing not available
  nix.settings.sandbox = lib.mkForce false;

  # Installing a new system within the nspawn means that the /sbin/init script
  # just needs to be updated, as there is no bootloader.
  system.build.installBootLoader = lib.mkForce bootScript;

  system.activationScripts.installInitScript = lib.mkForce ''
    ${pkgs.coreutils}/bin/ln -sf $systemConfig/init /sbin/init
  '';

  console.enable = lib.mkForce true;

  services.resolved.enable = false;

  environment.systemPackages = with pkgs; [
    nano
    wget
    curl
    git
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
