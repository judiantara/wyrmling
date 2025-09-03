{ ... }:

{
  imports = [
    ./bridge-network.nix
    ./hasufel.nix
    ./windfola.nix
    ./shadowfax.nix
    ../../config/workhorse-ssl.nix
  ];
}
