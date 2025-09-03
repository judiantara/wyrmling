{ pkgs, ... }:

{
  programs.zsh.enable = true;

  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    nix-zsh-completions
  ];
}
