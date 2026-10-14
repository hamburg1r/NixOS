{...}: {
  config.dendritic.nixos.microwave = [
    (
      {
        config,
        pkgs,
        ...
      }: let
        dataDir = "/mnt/other/homesync";
        liveKdbxSecrets = "${dataDir}/kdbx_secrets.json";
        # TODO(microwave): this secret is still encrypted for toaster's age key.
        # Re-encrypt for microwave and move it to secrets/hosts/microwave/homesync/.
        seedSecret = "hosts/toaster/homesync/kdbx_secrets.json";
        seededKdbxSecrets = config.sops.secrets.${seedSecret}.path;
      in {
        sops.secrets.${seedSecret} = {
          sopsFile = ../../secrets/hosts/toaster/homesync/kdbx_secrets.json;
          format = "binary";
          owner = "hamburgir";
          group = "users";
          mode = "0600";
        };

        services.homesync = {
          enable = true;
          host = "0.0.0.0";
          dataDir = dataDir;
          configPath = "/home/hamburgir/.config/homesync/config.toml";
          kdbxSecretsPath = liveKdbxSecrets;
          user = "hamburgir";
          group = "users";
          createUser = false;
          protectHome = false;
        };

        # Seed encrypted bootstrap → data dir once. Never clobber runtime API updates.
        systemd.services.homesync-seed-kdbx-secrets = {
          description = "Seed homesync kdbx secrets into data dir if missing";
          wantedBy = ["multi-user.target"];
          before = ["homesync.service"];
          after = [
            "local-fs.target"
            "sops-nix.service"
          ];
          wants = ["sops-nix.service"];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStart = pkgs.writeShellScript "homesync-seed-kdbx-secrets" ''
              set -eu
              dest=${pkgs.lib.escapeShellArg liveKdbxSecrets}
              src=${pkgs.lib.escapeShellArg seededKdbxSecrets}
              if [ ! -e "$dest" ]; then
              	install -D -m 0600 -o hamburgir -g users "$src" "$dest"
              fi
            '';
          };
        };

        systemd.services.homesync = {
          after = ["homesync-seed-kdbx-secrets.service"];
          wants = ["homesync-seed-kdbx-secrets.service"];
          serviceConfig.ReadWritePaths = [dataDir];
        };
        systemd.services.homesync-index.serviceConfig.ReadWritePaths = [dataDir];
      }
    )
  ];
}
