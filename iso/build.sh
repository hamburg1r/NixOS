#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || "$1" == --help || "$1" == -h ]]; then
  echo "Usage: nix run .#build-iso -- DESTINATION"
  echo "DESTINATION is an existing directory or an ISO file to create/replace."
  exit 0
fi
destination=$1
shift
if [[ $# -ne 0 ]]; then
  echo "Unexpected argument: $1" >&2
  exit 1
fi
if [[ -L "$destination" || ( -e "$destination" && ! -f "$destination" && ! -d "$destination" ) ]]; then
  echo "Destination must be a regular file or directory, not a symlink or device." >&2
  exit 1
fi

umask 077
build_dir=$(mktemp -d "${ISO_BUILD_TMPDIR:-${TMPDIR:-/tmp}}/opencode-iso.XXXXXXXX")
cleanup() {
  chmod -R u+w -- "$build_dir" || true
  rm -r -- "$build_dir" || echo "Warning: could not remove $build_dir" >&2
}
trap cleanup EXIT
secret_dir="$build_dir/secrets"
store_dir="$build_dir/store"
mkdir -m 700 -- "$secret_dir" "$store_dir"

if [[ ! -t 0 ]]; then
  echo "An interactive terminal is required for API key entry; ISO not built." >&2
  exit 1
fi
printf 'OpenAI API key (recoverable from ISO and Nix store; Enter to skip): ' >&2
IFS= read -r -s key || { echo >&2; echo "API key entry cancelled; ISO not built." >&2; exit 1; }
echo >&2

if [[ -n "$key" ]]; then
  age-keygen -o "$secret_dir/age-key.txt" 2>/dev/null
  recipient=$(age-keygen -y "$secret_dir/age-key.txt")
  printf %s "$key" | sops --config /dev/null encrypt \
    --age "$recipient" --input-type binary --output-type binary \
    --filename-override openai_api_key > "$secret_dir/openai_api_key"
  export ISO_SECRETS_DIR="$secret_dir"
else
  unset ISO_SECRETS_DIR
  echo "Building without an API key." >&2
fi
unset key

output=$(nix build --impure --no-link --print-out-paths \
  --store "$store_dir" --eval-store "$store_dir" --builders "" \
  .#nixosConfigurations.iso.config.system.build.isoImage)
shopt -s nullglob
images=("$store_dir$output"/iso/*.iso)
if [[ ${#images[@]} -ne 1 ]]; then
  echo "Expected one ISO in $output/iso; found ${#images[@]}." >&2
  exit 1
fi
if [[ -d "$destination" ]]; then
  destination="$destination/$(basename "${images[0]}")"
fi
if [[ -L "$destination" || ( -e "$destination" && ! -f "$destination" ) ]]; then
  echo "Refusing to replace a symlink or non-regular file: $destination" >&2
  exit 1
fi
cp -f -- "${images[0]}" "$destination"
echo "ISO copied to $destination"
