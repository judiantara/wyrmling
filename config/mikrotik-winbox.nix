{ ... }:

{
  nixpkgs.config.allowUnfree = true;

  programs.winbox = {
    enable = true;
    openFirewall = true;
  };
}
