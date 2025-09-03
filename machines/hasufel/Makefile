.PHONY: init update

init:
	@nix flake update
	@rm /etc/machine-id
	@nixos-rebuild boot --flake .\#hasufel
	@reboot

update:
	@nix flake update
	@nix-collect-garbage -d
	@nixos-rebuild boot --flake .\#hasufel
	@reboot
