{
    pkgs,
    ...
}: {
    boot = {
        tmp = {
            cleanOnBoot = true;
            useTmpfs = true;
            # tmpfsSize = "30%";
        };
        supportedFilesystems = [ "btrfs" "fat32" "ntfs" "vfat" ];
    };

    fileSystems."/nix" = {
        device = "/dev/disk/by-label/root";
        fsType = "btrfs";
        options = [ "subvol=nix" ];
    };

    fileSystems."/" = {
        device = "/dev/disk/by-label/root";
        fsType = "btrfs";
        options = [ "subvol=root" ];
    };

    fileSystems."/home" = {
        device = "/dev/disk/by-label/home";
        fsType = "btrfs";
    };

    fileSystems."/mnt/games" = {
        device = "/dev/disk/by-label/games";
        fsType = "ext4";
    };

    fileSystems."/mnt/other" = {
        device = "/dev/disk/by-label/other";
        fsType = "ext4";
    };

    # Periodic balance to prevent chunk imbalance recurring
    systemd.services."btrfs-balance-home" = {
        description = "BTRFS balance /home";
        after = [ "local-fs.target" ];
        serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.btrfs-progs}/bin/btrfs balance start -dusage=85 -musage=70 /home";
        };
    };

    systemd.timers."btrfs-balance-home" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
            OnCalendar = "weekly";
            Persistent = true;
        };
    };

    # Scrub — detects and corrects silent corruption (different from balance)
    services.btrfs.autoScrub = {
        enable = true;
        fileSystems = [ "/" "/home" ];
        interval = "monthly";
    };

    # Balance for root filesystem (covers /, /nix, /tmp, /var/tmp subvolumes)
    systemd.services."btrfs-balance-root" = {
        description = "BTRFS balance /";
        after = [ "local-fs.target" ];
        serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.btrfs-progs}/bin/btrfs balance start -dusage=85 -musage=70 /";
        };
    };

    systemd.timers."btrfs-balance-root" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
            OnCalendar = "weekly";
            Persistent = true;
            RandomizedDelaySec = "2h";
        };
    };
}
