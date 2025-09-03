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
mount /dev/disk/by-label/Kioxia32GB /wyvern
export VAULT_DIR=/wyvern/packages/key-vault/keys
export VAULT_KEY="$VAULT_DIR/wyvern.key.age"
```

## Run installation

```bash
export TARGET_MACHINE=talonwhip
. /wyvern/packages/scripts/run-ssh-patcher.sh
. /wyvern/packages/scripts/run-installer.sh
```

## Install UEFI boot loader

```bash
cp -rv /wyvern/packages/rpi4-uefi-firmware/* /mnt/boot/
```

## set LUKS key

```bash
cryptsetup luksAddKey /dev/disk/by-partlabel/Talonwhip --new-keyfile=/dev/disk/by-id/usb-UDISK_PDU01_2G_65A2.0_0000000000005D-0:0 --new-keyfile-size=1024 --new-keyfile-offset=2048
```
