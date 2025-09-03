{ ... }:
{
  disko.devices = {
    disk = {
      main = {
        content = {
          partitions = {
            luks = {
              content = {
                content = {
                  subvolumes = {
                    "/swap" = {
                      mountpoint = "/.swapvol";
                      swap.swapfile.size = "48G";
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
