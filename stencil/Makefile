# If the first argument is good pass the rest of the line to the target
ifneq (,$(filter $(firstword $(MAKECMDGOALS)),destroy machine net nopw))
  # use second target as machine name
  MACHINE_NAME := $(word 2, $(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(MACHINE_NAME):;@:)
endif

.PHONY: destroy list machine net nopw tarball

tarball:
	@rm -rf ./result
	nix flake update
	nix build

list:
	@sudo machinectl list-images

ifdef MACHINE_NAME
destroy:
	@echo "Removing machine $(MACHINE_NAME)..."
	@sudo machinectl stop $(MACHINE_NAME) || true
	@sleep 3
	@sudo machinectl remove $(MACHINE_NAME)
	@sudo machinectl list-images

machine:
	@echo "importing as $(MACHINE_NAME)..."
	@sudo importctl import-tar -m ./result/tarball/nixos-system-x86_64-linux.tar.xz $(MACHINE_NAME)
	@sudo machinectl list-images

net:
	@echo "Set ${MACHINE_NAME} networking zone"
	@sudo cp /etc/systemd/nspawn/stencil.nspawn /etc/systemd/nspawn/${MACHINE_NAME}.nspawn
	@ls -alh /etc/systemd/nspawn

nopw:
	@echo "Connecting to $(MACHINE_NAME)..."
	@sudo machinectl start $(MACHINE_NAME)
	@sleep 3
	@sudo machinectl shell root@$(MACHINE_NAME) /run/wrappers/bin/passwd -d root
	@sudo machinectl stop $(MACHINE_NAME)
else
destroy:
	@echo 'run "make rmm <machine name>" to destroy <machine name>'

machine:
	@echo 'run "make machine <machine name>" to generate new container named <nachine name>'

net:
	@echo 'run "make net <machine name>" to add <machine name> into workhorses network zone'

nopw:
	@echo 'run "make rmp <machine name>" to remove root password in <machine name>'
endif
