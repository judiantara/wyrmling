{ name, size }:
{ ... }:
{
  disko.devices = {
    disk = {
      main = {
        content = {
          partitions = {
            luks = {
              content = {
                name = "${name}";
                content = {
                  type = "btrfs";
                  subvolumes = {
                    "/swap" = {
                      mountpoint = "/.swapvol";
                      swap.swapfile.size = "${size}";
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

