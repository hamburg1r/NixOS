# Deploy ham's SOPS-managed outbound identity without putting the private key
# into the Nix store. Preserve a previously generated key if one exists.
{...}: {
  config.dendritic.nixos.toaster = [
    (
      {config, pkgs, ...}: let
        sshKey = "hosts/toaster/ham/ssh/id_ed25519";
        secretPath = config.sops.secrets.${sshKey}.path;
      in {
        sops.secrets.${sshKey} = {
          sopsFile = ../../secrets/hosts/toaster/ham/ssh/id_ed25519;
          format = "binary";
          owner = "ham";
          group = "users";
          mode = "0600";
        };

        systemd.services.ham-ssh-key = {
          description = "Expose ham's SOPS-managed SSH identity";
          wantedBy = ["multi-user.target"];
          unitConfig.RequiresMountsFor = "/home/ham";
          serviceConfig = {
            Type = "oneshot";
            User = "ham";
            Group = "users";
            UMask = "0077";
            ExecStart = pkgs.writeShellScript "ham-ssh-key" ''
              set -eu
              mkdir -p /home/ham/.ssh
              chmod 700 /home/ham/.ssh
              dest=/home/ham/.ssh/id_ed25519
              src=${pkgs.lib.escapeShellArg secretPath}
              test -r "$src"
              if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
                : # Already managed.
              elif [ -e "$dest" ] || [ -L "$dest" ]; then
                # Never overwrite an identity created before this change.
                if [ -e "$dest.pre-sops" ] || [ -L "$dest.pre-sops" ]; then
                  echo "Refusing to replace $dest: backup already exists" >&2
                  exit 1
                fi
                mv "$dest" "$dest.pre-sops"
                ln -s "$src" "$dest"
              else
                ln -s "$src" "$dest"
              fi
              ${pkgs.coreutils}/bin/install -m 0644 ${../../users/ham/ssh/id_ed25519.pub} /home/ham/.ssh/id_ed25519.pub
            '';
          };
        };
      }
    )
  ];
}
