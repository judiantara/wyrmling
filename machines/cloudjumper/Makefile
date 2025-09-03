.PHONY: update upgrade

update:
	nix flake update
	nixos-rebuild switch

upgrade:
	nix-collect-garbage -d
	nixos-rebuild boot
