# Builds the repo-local helper library (see lib/) and exposes it to the
# NixOS/Home Manager evaluations as `outputs.lib`.
{
  lib,
  config,
  ...
}: {
  config.dendritic.lib = import ../lib {inherit lib;};
}
