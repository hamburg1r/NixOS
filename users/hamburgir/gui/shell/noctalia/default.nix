{
  config,
  lib,
  ...
}:
let
  settingsDir = ./settings;
  importedSettings = lib.mapAttrs (name: value: import value)
    (lib.filterAttrs (name: value: lib.hasSuffix ".nix" name)
      (builtins.readDir settingsDir));
in
{
  programs.noctalia-shell = {
    enable = false;
    # settings = lib.foldl' lib.recursiveUpdate {} (builtins.attrValues importedSettings);
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        "music-search" = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 2;
    };
  };
}
