{ ... }:

{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/ata-EYOTA-240GB_AA202205211472";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size  = "512M";
              type  = "EF00";
              label = "TalonWhipESP";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              type = "8304";
              label = "TalonWhip";
              content = {
                type = "luks";
                name = "TalonWhip";
                extraOpenArgs = [
                  "--allow-discards"
                  "--perf-no_read_workqueue"
                  "--perf-no_write_workqueue"
                ];
                passwordFile = "/tmp/fob.key";
                settings = {
                  allowDiscards = true;
                };
                additionalKeyFiles = [];
                content = {
                  type = "btrfs";
                  extraArgs = ["-L" "TalonWhip" "-f"];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [ "compress=zstd" "noatime" "nodiratime" "discard" ];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [ "compress=zstd" "noatime" "nodiratime" "discard" ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd" "noatime" "nodiratime" "discard" ];
                    };
                    "/swap" = {
                      mountpoint = "/.swapvol";
                      swap.swapfile.size = "16G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
