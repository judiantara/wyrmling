{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # shell
    ondir
    tmux

    # utils
    mc
    ripgrep # recursively searches directories for a regex pattern
    jq      # A lightweight and flexible command-line JSON processor
    yq-go   # yaml processor https://github.com/mikefarah/yq
    eza     # A modern replacement for ‘ls’
    fzf     # A command-line fuzzy finder
    btop    # replacement of htop/nmon
    iotop   # io monitoring
    iftop   # network monitoring
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    zip
    xz
    unzip
    openssl
    dig
    inetutils
    pciutils
    usbutils
    nixos-firewall-tool
    unixtools.net-tools
    cyme
    nvtopPackages.amd
    microcode-amd
    amdctl
    wireguard-tools
    iptables
    sqlite
    linuxPackages.usbip
    libxfs
    xfs-undelete
    xfsprogs
    ntfs3g
  ];
}
