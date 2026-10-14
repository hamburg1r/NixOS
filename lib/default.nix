# Repo-local helper library. Exposed to NixOS/Home Manager modules as
# `outputs.lib` (see parts/lib.nix).
#
# Current namespaces:
#   - apps: builders for `desktop.apps.<name>` modules (see ./apps.nix).
{lib}: import ./apps.nix {inherit lib;}
