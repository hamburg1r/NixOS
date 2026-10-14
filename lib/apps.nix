# Shared builders for `desktop.apps.<name>` modules.
#
# Every app module follows the same shape: an `enable` flag plus a `package`,
# and installing the package somewhere when enabled. These helpers remove the
# per-file `mkApp`/`mkPkg` duplication.
#
# `mkApp` is the generic primitive; the rest are thin wrappers that choose
# where the package is installed (home.packages, environment.systemPackages,
# fonts.packages) or enable a `programs.<name>` module.
{lib}: rec {
  # Generic builder. `install` receives the resolved app config and returns
  # the config fragment to apply when the app is enabled.
  mkApp = pkgs: {
    name,
    pkg ? name,
    description ? name,
    install,
    ...
  }: {config, ...}: let
    cfg = config.desktop.apps.${name};
  in {
    options.desktop.apps.${name} = {
      enable = lib.mkEnableOption description;
      package = lib.mkPackageOption pkgs pkg {};
    };

    config = lib.mkIf cfg.enable (install cfg);
  };

  # Install into Home Manager's `home.packages`.
  mkHome = pkgs: spec:
    mkApp pkgs (spec // {install = cfg: {home.packages = [cfg.package];};});

  # Install into NixOS's `environment.systemPackages`.
  mkSystem = pkgs: spec:
    mkApp pkgs (spec // {install = cfg: {environment.systemPackages = [cfg.package];};});

  # Install into NixOS's `fonts.packages`.
  mkFont = pkgs: spec:
    mkApp pkgs (spec // {install = cfg: {fonts.packages = [cfg.package];};});

  # Enable `programs.<program>` with the app's package, merging any `settings`.
  # Set `usePackage = false` when the program's own module supplies the
  # package (e.g. `programs.lf`, wrapped in modules/home-manager/lf).
  mkProgram = pkgs: program: spec:
    mkApp pkgs (spec
      // {
        install = cfg: {
          programs.${program} = lib.mkMerge [
            (lib.optionalAttrs (spec.usePackage or true) {package = cfg.package;})
            {enable = spec.enable or true;}
            (spec.settings or {})
          ];
        };
      });
}
