# Install NixOS on RPi 4 wbooth with uefi and using vanilla kernel

## Boot using RPi 4 NixOS Installer image

* Switch to root user
```bash
sudo -i
```

## Make required package available
```bash
nix-shell -p rage disko cryptsetup openssl parted git gptfdisk e2fsprogs dosfstools efibootmgr mc
```

## Enable flake

Add following lines to /etc/nix/nix.conf
```txt
download-buffer-size = 524288000
experimental-features = nix-command flakes
```

```bash
rm /etc/nix/nix.conf
cp -L /etc/static/nix/nix.conf /etc/nix/nix.conf
chmod 644 /etc/nix/nix.conf
nano /etc/nix/nix.conf
```

## Mount wyvern keys and scripts
```bash
mkdir -p /wyvern
mount /dev/sdc /wyvern
export VAULT_DIR=/wyvern/key-vault/keys
export VAULT_KEY="$VAULT_DIR/wyvern.key.age"
```

## Run installation
```bash
export TARGET_MACHINE=talonwhip
. /wyvern/scripts/run-ssh-patcher.sh
. /wyvern/scripts/run-installer.sh
```
