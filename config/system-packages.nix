{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # sysmon
    btop    # replacement of htop/nmon
    iotop   # io monitoring
    iftop   # network monitoring

    # file utils
    ripgrep # recursively searches directories for a regex pattern
    jq      # A lightweight and flexible command-line JSON processor
    yq-go   # yaml processor https://github.com/mikefarah/yq
    eza     # A modern replacement for ‘ls’
    fzf     # A command-line fuzzy finder
    yazi

    # networking
    openssl
    wireguard-tools
    nixos-firewall-tool

    # devices
    pciutils
    usbutils
    cyme
    nvtopPackages.amd
    microcode-amd
    amdctl
    sqlite

    # filesystem
    libxfs
    xfs-undelete
    xfsprogs
    ntfs3g
    f2fs-tools
    gptfdisk
    e2fsprogs
    zerofree
    exfatprogs
  ];
}
