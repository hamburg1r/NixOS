#!/usr/bin/env bash
set -euo pipefail

REPO=/home/hamburgir/repo/NixOS
KEYDIR=/tmp/age-setup
mkdir -p "$KEYDIR"

echo "[*] Generating 3 age keypairs (toaster, microwave, hamburgir)..."
age-keygen -o "$KEYDIR/toaster.key" 2> "$KEYDIR/toaster.pub"
age-keygen -o "$KEYDIR/microwave.key" 2> "$KEYDIR/microwave.pub"
age-keygen -o "$KEYDIR/hamburgir.key" 2> "$KEYDIR/hamburgir.pub"

TOASTER_PUB=$(grep -oP 'age1[a-z0-9]+' "$KEYDIR/toaster.pub")
MICROWAVE_PUB=$(grep -oP 'age1[a-z0-9]+' "$KEYDIR/microwave.pub")
HAMBURGIR_PUB=$(grep -oP 'age1[a-z0-9]+' "$KEYDIR/hamburgir.pub")

echo "[*] Pubkeys:"
echo "  toaster:   $TOASTER_PUB"
echo "  microwave: $MICROWAVE_PUB"
echo "  hamburgir: $HAMBURGIR_PUB"

cat > "$REPO/.sops.yaml" << EOF
keys:
  - &hamburgir $HAMBURGIR_PUB
  - &toaster $TOASTER_PUB
  - &microwave $MICROWAVE_PUB
creation_rules:
  - path_regex: secrets/users/.*
    key_groups:
      - age:
          - *hamburgir
          - *toaster
          - *microwave
  - path_regex: secrets/hosts/toaster/.*
    key_groups:
      - age:
          - *toaster
          - *hamburgir
  - path_regex: secrets/hosts/microwave/.*
    key_groups:
      - age:
          - *microwave
          - *hamburgir
EOF

echo "[*] Updated .sops.yaml"

echo "[*] Installing keys on this machine (microwave)..."
sudo mkdir -p /var/lib/sops-nix
sudo cp "$KEYDIR/microwave.key" /var/lib/sops-nix/key.txt
sudo chmod 600 /var/lib/sops-nix/key.txt
sudo chown root:root /var/lib/sops-nix/key.txt

mkdir -p ~/.config/sops/age
cp "$KEYDIR/hamburgir.key" ~/.config/sops/age/keys.txt
chmod 600 ~/.config/sops/age/keys.txt

echo "[*] Putting toaster key in /tmp for later move..."
cp "$KEYDIR/toaster.key" /tmp/toaster-sops-age.key
chmod 600 /tmp/toaster-sops-age.key

echo "[*] Re-encrypting existing secrets..."
cd "$REPO"
for f in secrets/users/hamburgir/github_token secrets/users/hamburgir/devto_api_key secrets/hosts/toaster/remote-build/ssh_key secrets/hosts/toaster/homesync/kdbx_secrets.json; do
  [ -f "$f" ] || continue
  echo "  -> $f"
  tmp=$(mktemp)
  sops -d "$f" > "$tmp"
  out=$(mktemp)
  sops --encrypt --input-type binary --output-type binary --filename-override "$f" "$tmp" > "$out"
  mv "$out" "$f"
  rm -f "$tmp"
done

echo "[*] Verifying..."
sops -d secrets/users/hamburgir/github_token >/dev/null && echo "  user/github_token: OK"
sops -d secrets/users/hamburgir/devto_api_key >/dev/null && echo "  user/devto_api_key: OK"
sops -d secrets/hosts/toaster/remote-build/ssh_key >/dev/null && echo "  hosts/toaster/remote-build/ssh_key: OK"
sops -d secrets/hosts/toaster/homesync/kdbx_secrets.json >/dev/null && echo "  hosts/toaster/homesync/kdbx_secrets.json: OK"

echo "[*] Done. Keys in $KEYDIR"
echo "  - toaster key (put on toaster): /tmp/toaster-sops-age.key -> /var/lib/sops-nix/key.txt"
echo "  - hamburgir key in: ~/.config/sops/age/keys.txt (and in $KEYDIR/hamburgir.key)"
echo "  - microwave key in: /var/lib/sops-nix/key.txt"
