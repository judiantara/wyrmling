{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size  = "512M";
              type  = "EF00";
              label = "StormflyESP";
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
              label = "Stormfly";
              content = {
                type = "luks";
                name = "stormfly";
                extraOpenArgs = [
                  "--allow-discards"
                  "--perf-no_read_workqueue"
                  "--perf-no_write_workqueue"
                ];
                # use interactive password entry
                settings = {
                  allowDiscards = true;
                };
                additionalKeyFiles = [];
                content = {
                  type = "btrfs";
                  extraArgs = ["-L" "stormfly" "-f"];
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
