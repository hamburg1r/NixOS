# Repo-local helper library. Exposed to NixOS/Home Manager modules as
# `outputs.lib` (see parts/lib.nix).
#
# Current namespaces:
#   - apps: builders for `desktop.apps.<name>` modules (see ./apps.nix).
#   - niri: package helpers for the niri compositor (see ./niri.nix).
{lib}: {
  niri = import ./niri.nix {inherit lib;};
}
// (import ./apps.nix {inherit lib;})
