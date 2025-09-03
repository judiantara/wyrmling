{ device, name }:
{ ... }:
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "${device}";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size  = "512M";
              type  = "EF00";
              label = "${name}ESP";
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
              label = "${name}";
              content = {
                type = "luks";
                name = "${name}";
                extraOpenArgs = [
                  "--allow-discards"
                  "--perf-no_read_workqueue"
                  "--perf-no_write_workqueue"
                ];
                # use interactive password entry
                passwordFile = "/run/fob.key";
                settings = {
                  allowDiscards = true;
                };
                additionalKeyFiles = [];
                content = {
                  type = "btrfs";
                  extraArgs = ["-L" "${name}" "-f"];
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
