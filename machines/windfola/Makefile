.PHONY: init update

init:
	@nix flake update
	@rm /etc/machine-id
	@nixos-rebuild boot --flake .\#windfola
	@reboot

update:
	@nix flake update
	@nixos-rebuild boot --flake .\#windfola
	@nix-collect-garbage -d
	@reboot
