{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WDC_PC_SN520_SDAPNUW-256G-1014_20270F804683";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["defaults"];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "utero";
                passwordFile = "/tmp/secret.key"; # Interactive
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];
                  subvolumes = {
                    "/@root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/@home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/@swap" = {
                      mountpoint = "/.swapvol";
                      swap.swapfile.size = "8G";
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
