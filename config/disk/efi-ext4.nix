{ device, name, swapSize }:
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
            swap = {
              size = "${swapSize}";
              label = "${name}Swap";
              content = {
                type = "swap";
                discardPolicy = "both";
              };
            };
            root = {
              size = "100%";
              type = "8304";
              label = "${name}";
              content = {
                type = "filesystem";
                format = "ext4";
                extraArgs = ["-L" "${name}"];
                mountpoint = "/";
                mountOptions = [ "noatime" "nodiratime" "discard" ];
              };
            };
          };
        };
      };
    };
  };
}
