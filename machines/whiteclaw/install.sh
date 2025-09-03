#!/usr/bin/env bash

exec nixos-install --channel unstable --no-channel-copy --no-root-password --flake "/mnt/etc/nixos#whiteclaw" --root /mnt --cores 0
