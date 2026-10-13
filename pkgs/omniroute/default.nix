{pkgs}:
pkgs.writeShellApplication {
  name = "omniroute";
  runtimeInputs = [pkgs.nodejs_22];
  text = ''
    set -euo pipefail
    export OMNIROUTE_MEMORY_MB="''${OMNIROUTE_MEMORY_MB:-1024}"
    export OMNIROUTE_DISABLE_BACKGROUND_SERVICES="''${OMNIROUTE_DISABLE_BACKGROUND_SERVICES:-true}"

    CACHE_ROOT="''${XDG_CACHE_HOME:-$HOME/.cache}"
    PREFIX="''${OMNIROUTE_NIX_PREFIX:-$CACHE_ROOT/omniroute-nix}"
    QODER_PREFIX="''${QODERCLI_NIX_PREFIX:-$CACHE_ROOT/qodercli-nix}"
    VERSION="''${OMNIROUTE_NPM_VERSION:-latest}"
    QODER_VERSION="''${QODERCLI_NPM_VERSION:-latest}"

    mkdir -p "$PREFIX" "$QODER_PREFIX"
    if [ ! -x "$PREFIX/node_modules/.bin/omniroute" ]; then
    	echo "Installing omniroute@$VERSION into $PREFIX (one-time)…"
    	npm install --prefix "$PREFIX" "omniroute@$VERSION"
    fi
    if [ ! -x "$QODER_PREFIX/node_modules/.bin/qodercli" ]; then
    	echo "Installing @qoder-ai/qodercli@$QODER_VERSION into $QODER_PREFIX (one-time)…"
    	npm install --prefix "$QODER_PREFIX" "@qoder-ai/qodercli@$QODER_VERSION"
    fi

    export PATH="${pkgs.nodejs_22}/bin:$QODER_PREFIX/node_modules/.bin:$PATH"
    # OmniRoute PAT auth spawns qodercli; point at the absolute npm bin.
    export CLI_QODER_BIN="$QODER_PREFIX/node_modules/.bin/qodercli"

    cd "$PREFIX"
    BIN="$PREFIX/node_modules/.bin/omniroute"

    # Subcommands (setup, reset-password, connect, …) — pass through unchanged.
    if [ "$#" -gt 0 ] && [[ "''${1:-}" != -* ]]; then
    	exec "$BIN" "$@"
    fi

    # Bare invoke / serve flags — potato defaults (daemon unless foreground).
    echo "Starting OmniRoute (heap=''${OMNIROUTE_MEMORY_MB}MB, background services off by default)"
    if [ "''${OMNIROUTE_FOREGROUND:-}" = "1" ]; then
    	exec "$BIN" --no-open "$@"
    fi
    exec "$BIN" --daemon --no-open "$@"
  '';
}
