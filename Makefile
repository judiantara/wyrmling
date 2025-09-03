MAKEFLAGS += --always-make

all: flake commit

flake:
	nix flake update

commit:
	git al && git cia "My Nix Home manager" && git fp

pull:
	git ompull
