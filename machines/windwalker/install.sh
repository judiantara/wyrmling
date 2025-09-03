#!/usr/bin/env bash

exec nixos-install --channel unstable --no-channel-copy --no-root-password --flake "/mnt/etc/nixos#windwalker" --root /mnt --cores 0
