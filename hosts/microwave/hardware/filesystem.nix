{...}: {
  config.dendritic.nixos.microwave = [
    (
      {
        pkgs,
        ...
      }: {
        boot = {
          tmp = {
            cleanOnBoot = true;
            useTmpfs = true;
          };
          supportedFilesystems = ["btrfs" "fat32" "ntfs" "vfat"];

          # Resume from the nocow swapfile in the btrfs `swap` subvolume.
          # Recompute the Btrfs-specific resume offset with
          #   sudo btrfs inspect-internal map-swapfile -r /swap/swapfile
          # if the swapfile is ever recreated.
          resumeDevice = "/dev/disk/by-label/root";
          kernelParams = [
            "resume_offset=533760"
          ];
        };

        fileSystems."/" = {
          device = "/dev/disk/by-label/root";
          fsType = "btrfs";
          options = ["subvol=root" "noatime"];
        };

        fileSystems."/nix" = {
          device = "/dev/disk/by-label/root";
          fsType = "btrfs";
          options = ["subvol=nix" "noatime"];
        };

        fileSystems."/home" = {
          device = "/dev/disk/by-label/root";
          fsType = "btrfs";
          options = ["subvol=home" "noatime"];
        };

        fileSystems."/home/hamburgir/Games" = {
          device = "/dev/disk/by-label/root";
          fsType = "btrfs";
          options = ["subvol=home/hamburgir/Games" "noatime"];
        };

        fileSystems."/swap" = {
          device = "/dev/disk/by-label/root";
          fsType = "btrfs";
          options = ["subvol=swap" "noatime"];
        };

        fileSystems."/var/log" = {
          device = "/dev/disk/by-label/root";
          fsType = "btrfs";
          options = ["subvol=log" "noatime"];
        };

        fileSystems."/.snapshots" = {
          device = "/dev/disk/by-label/root";
          fsType = "btrfs";
          options = ["subvol=snapshots" "noatime"];
        };

        fileSystems."/boot/efi" = {
          device = "/dev/disk/by-label/EFI";
          fsType = "vfat";
          options = ["fmask=0022" "dmask=0022"];
        };

        swapDevices = [
          {
            device = "/swap/swapfile";
          }
        ];

        # Periodic balance to prevent chunk imbalance recurring
        systemd.services."btrfs-balance-home" = {
          description = "BTRFS balance /home";
          after = ["local-fs.target"];
          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.btrfs-progs}/bin/btrfs balance start -dusage=85 -musage=70 /home";
          };
        };

        systemd.timers."btrfs-balance-home" = {
          wantedBy = ["timers.target"];
          timerConfig = {
            OnCalendar = "weekly";
            Persistent = true;
          };
        };

        # Scrub — detects and corrects silent corruption (different from balance)
        services.btrfs.autoScrub = {
          enable = true;
          fileSystems = ["/" "/home"];
          interval = "monthly";
        };

        # Balance for root filesystem (covers /, /nix, /tmp, /var/tmp subvolumes)
        systemd.services."btrfs-balance-root" = {
          description = "BTRFS balance /";
          after = ["local-fs.target"];
          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.btrfs-progs}/bin/btrfs balance start -dusage=85 -musage=70 /";
          };
        };

        systemd.timers."btrfs-balance-root" = {
          wantedBy = ["timers.target"];
          timerConfig = {
            OnCalendar = "weekly";
            Persistent = true;
            RandomizedDelaySec = "2h";
          };
        };
      }
    )
  ];
}
