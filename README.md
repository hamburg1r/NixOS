# NixOS

Personal NixOS flake configuration for **toaster** and **microwave** (`x86_64-linux`), with Home Manager for **hamburgir**.

- **toaster** — older laptop: gaming/desktop + bluetooth, no server roles.
- **microwave** — newer desktop (Ryzen 7 5700X + RX 7600): gaming/desktop, runs the `homesync` and `syncthing` servers, no wifi/bluetooth, Windows dual-boot (lanzaboote + Secure Boot).

This repo uses the modern Nix CLI (`nix` / flakes) and [nh](https://github.com/viperML/nh) for rebuilds.

## Dendritic layout

Every non-entry `.nix` file under `parts/`, `hosts/`, `users/`, and `modules/` is a top-level module picked up automatically by `import-tree` (paths containing `/_` are ignored). Modules self-register via the `dendritic` options defined in `parts/options.nix`:

- `config.dendritic.nixos.{common,toaster,microwave}`
- `config.dendritic.home.{common,hamburgir,disabled}`

Hosts are assembled in `parts/hosts/*.nix` by composing the relevant groups.

## Prerequisites

- Flakes and `nix-command` enabled (configured in `hosts/common/default.nix`)
- For editing secrets locally: age key at `~/.config/sops/age/keys.txt`

Optional dev shell (includes `sops`, `age`, `home-manager`, etc.):

```bash
nix develop
# or
nix-shell
```

## Installation

Build the installer ISO locally:

```bash
nix build .#iso
```

Boot the resulting image, partition/format disks, then install from a checkout of this flake:

```bash
sudo nixos-install --flake .#toaster
# or
sudo nixos-install --flake .#microwave
```

Or install directly from GitHub without cloning first:

```bash
sudo nixos-install --flake github:h4m6urg1r/NixOS#toaster
sudo nixos-install --flake github:h4m6urg1r/NixOS#microwave
```

After install, reboot into the new system. Home Manager is applied separately (see below).

## Rebuild commands

**Preferred:** use `nh` (enabled system-wide; flake path is `/home/hamburgir/repo/NixOS` in `hosts/common/default.nix`).

From the repo root:

```bash
# NixOS system
nh os switch

# Home Manager (user hamburgir)
nh home switch
```

### Alternatives (nix3 / classic)

Equivalent commands if you prefer not to use `nh`:

```bash
# NixOS
sudo nixos-rebuild switch --flake .#toaster
sudo nixos-rebuild switch --flake .#microwave

# Home Manager
home-manager switch --flake .#hamburgir
```

Other useful `nh` subcommands:

```bash
nh os boot      # apply at next boot
nh os test      # build and activate in a test environment
nh home build   # build without switching
```

Update flake inputs:

```bash
nix flake update
```

## Secrets

Secrets are managed with [sops-nix](https://github.com/Mic92/sops-nix) and [sops](https://github.com/getsops/sops) using **age** keys defined in `.sops.yaml`.

| Path | Decrypted by | Runtime key |
|------|--------------|-------------|
| `secrets/hosts/...` | system + user | `/var/lib/sops-nix/key.txt` |
| `secrets/users/...` | user only | `~/.config/sops/age/keys.txt` |

Host secrets under `secrets/hosts/` are encrypted for both the system and user age keys so you can edit them locally. User secrets under `secrets/users/` are user-only.

### Adding a secret

1. **Create or edit the encrypted file** (from the dev shell):

   ```bash
   # User secret
   sops edit secrets/users/hamburgir/my_secret

   # Host secret
   sops edit secrets/hosts/toaster/my_service/credentials.json
   ```

   `sops` picks recipients from `.sops.yaml` based on the file path.

2. **Declare it in Nix**

   **User secret** — add to `users/hamburgir/sops.nix`:

   ```nix
   let
     mySecret = "users/hamburgir/my_secret";
   in {
     sops.secrets.${mySecret} = {
       sopsFile = ../../secrets/users/hamburgir/my_secret;
       format = "binary"; # omit for JSON/YAML key lookup
     };

     # Optional: inject into a generated config
     sops.templates."my-config".content = ''
       token = ${config.sops.placeholder.${mySecret}}
     '';
   }
   ```

   **Host secret** — add to a host module (e.g. `hosts/toaster/homesync.nix`):

   ```nix
   let
     secretName = "hosts/toaster/my_service/credentials.json";
   in {
     sops.secrets.${secretName} = {
       sopsFile = ../../secrets/hosts/toaster/my_service/credentials.json;
       format = "binary";
       owner = "hamburgir";
       group = "users";
       mode = "0600";
     };
   }
   ```

3. **Apply**

   ```bash
   nh home switch   # user secrets
   nh os switch     # host secrets
   ```

   Decrypted secrets are available at runtime via `config.sops.secrets.<name>.path` or `config.sops.placeholder.<name>` in templates.

### Existing examples

- **User secret + nix access token template:** `users/hamburgir/sops.nix` (`github_token`)
- **Host secret + systemd seeding:** `hosts/microwave/homesync.nix` (`kdbx_secrets.json`)

> TODO(microwave): the homesync secret is still encrypted for **toaster's** age key. Re-encrypt it for microwave (`sops updatekeys secrets/hosts/toaster/homesync/kdbx_secrets.json`) after adding the microwave key to `.sops.yaml`, and move it to `secrets/hosts/microwave/homesync/`.

## Flake outputs

| Output | Description |
|--------|-------------|
| `nixosConfigurations.toaster` | Laptop (gaming/desktop, bluetooth) |
| `nixosConfigurations.microwave` | Desktop (gaming/desktop, homesync+syncthing servers, lanzaboote + Secure Boot) |
| `nixosConfigurations.iso` | Installer/recovery ISO |
| `homeConfigurations.hamburgir` | Home Manager config |
| `packages.x86_64-linux.iso` | ISO image build |

## Microwave first-boot notes

- **Windows dual boot:** lanzaboote only manages NixOS entries, so there is no chainload entry for Windows. Boot Windows from the firmware boot menu (e.g. F12), or add a manual systemd-boot entry under `/boot/efi/loader/entries/`. Install Windows to the partition labeled `Windows` (mounted at `/mnt/windows`).
- **Secure Boot:** lanzaboote signs the unified kernel images with the `sbctl` keys in `/var/lib/sbctl`. On first boot:
  1. `sbctl create-keys`
  2. reset Secure Boot to "setup mode" in the BIOS, then `sbctl enroll-keys -m -f`
  3. rebuild (`nixos-rebuild switch`), then enable Secure Boot in the BIOS.
- **ESP generations:** `boot.lanzaboote.configurationLimit` is set to 4 on a ~500M ESP (~100M per UKI). Raise/lower it to match the actual ESP size.
