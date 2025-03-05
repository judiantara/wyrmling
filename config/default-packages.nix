{lib, config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    nano
    wget
    curl

    # shell
    nix-zsh-completions
    ondir
    tmux
    mc

    # utils
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
    gnumake
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
    cyme
    nvtopPackages.amd
    microcode-amd
    amdctl
    wireguard-tools
    iptables
    sqlite
    linuxPackages.usbip
  ];
}
