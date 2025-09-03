# Determine this makefile's path.
# Be sure to place this BEFORE `include` directives, if any.
THIS_FILE := $(lastword $(MAKEFILE_LIST))

# If the first argument is good pass the rest of the line to the target
ifneq (,$(filter $(firstword $(MAKECMDGOALS)),destroy login machine net nopw ready ssh start stop))
  # use second target as machine name
  MACHINE_NAME := $(word 2, $(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(MACHINE_NAME):;@:)
endif

define _nspawn_config
[Network]
Zone = workhorses

[Files]
PrivateUsersOwnership=map
Bind=/dev/fuse
Bind=/home/judiantara/Workspaces
BindReadOnly=/home/judiantara/.ssh
endef

export nspawn_config = $(value _nspawn_config)

.PHONY: tarball lsimg lscon ready destroy login machine net nopw start stop

tarball:
	@rm -rf ./result
	nix flake update
	nix build

lsimg:
	@sudo machinectl list-images

lscon:
	@sudo machinectl

ifdef MACHINE_NAME
ready:
	@@$(MAKE) -sf $(THIS_FILE)  machine $(MACHINE_NAME)
	@@$(MAKE) -sf $(THIS_FILE)  net     $(MACHINE_NAME)
	@@$(MAKE) -sf $(THIS_FILE)  start   $(MACHINE_NAME)
	@@$(MAKE) -sf $(THIS_FILE)  nopw    $(MACHINE_NAME)
	@@$(MAKE) -sf $(THIS_FILE)  login   $(MACHINE_NAME)

destroy:
	@echo "Removing machine $(MACHINE_NAME)..."
	@sudo machinectl stop $(MACHINE_NAME) || true
	@sleep 3
	@sudo machinectl remove $(MACHINE_NAME) || true
	@echo "Done!"
	@echo
	@sudo machinectl list-images

login:
	@echo "Power on machine $(MACHINE_NAME)..."
	@sudo machinectl start $(MACHINE_NAME)
	@sudo sleep 3
	@echo "Login to $(MACHINE_NAME)..."
	@sudo machinectl login $(MACHINE_NAME)
	@echo "Done!"

machine:
	@echo "importing as $(MACHINE_NAME)..."
	@sudo importctl import-tar -m ./result/tarball/nixos-system-x86_64-linux.tar.xz $(MACHINE_NAME)
	@echo "Done!"
	@echo
	@sudo machinectl list-images

net:
	@echo "Set ${MACHINE_NAME} networking zone"
	@echo "$$nspawn_config" | sudo tee /etc/systemd/nspawn/${MACHINE_NAME}.nspawn
	@echo "Done!"
	@echo
	@ls -alh /etc/systemd/nspawn

nopw:
	@echo "Removing root password from $(MACHINE_NAME)..."
	@sudo machinectl shell root@$(MACHINE_NAME) /run/wrappers/bin/passwd -d root
	@echo "Done!"
	@echo
	@sudo machinectl

# ssh:
# 	@echo "Set host ssh keys for $(MACHINE_NAME)..."
# 	@sudo mkdir -p /var/lib/machines/$(MACHINE_NAME)/nix/persist
# 	@sudo cp -rL ~/Workspaces/personal/nix/atelier/source/machine-persisted/$(MACHINE_NAME)/etc /var/lib/machines/$(MACHINE_NAME)/nix/persist
# 	@sudo find /var/lib/machines/$(MACHINE_NAME)/nix/persist/ -type f -name "*.pub" -exec chmod 444 {} \;
# 	@sudo find /var/lib/machines/$(MACHINE_NAME)/nix/persist/ -type f -name "*_key" -exec chmod 400 {} \;
# 	@echo "Done!"
# 	@echo
# 	@sudo ls -alhR /var/lib/machines/$(MACHINE_NAME)/nix/persist

start:
	@echo "Power on machine $(MACHINE_NAME)..."
	@sudo machinectl start $(MACHINE_NAME)
	@sudo sleep 3
	@echo "Done!"
	@echo
	@sudo machinectl

stop:
	@echo "Power off machine $(MACHINE_NAME)..."
	@sudo machinectl stop $(MACHINE_NAME) || true
	@sudo sleep 3
	@echo "Done!"
	@echo
	@sudo machinectl
else
ready:
	@echo 'run "make ready <machine name>" to create and start <machine name>'

destroy:
	@echo 'run "make rmm <machine name>" to destroy <machine name>'

login:
	@echo 'run "make login <machine name>" to login into <nachine name>'

machine:
	@echo 'run "make machine <machine name>" to generate new container named <nachine name>'

net:
	@echo 'run "make net <machine name>" to add <machine name> into workhorses network zone'

nopw:
	@echo 'run "make nopw <machine name>" to remove root password in <machine name>'

# ssh:
# 	@echo 'run "make ssh <machine name>" to set up <machine name> ssh keys'

start:
	@echo 'run "make start <machine name>" to start <machine name>'

stop:
	@echo 'run "make ssh <machine name>" to stop <machine name>'
endif
