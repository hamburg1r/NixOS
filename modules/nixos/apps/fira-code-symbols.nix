{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.fira-code-symbols;
      in {
        options.desktop.apps.fira-code-symbols = {
          enable = lib.mkEnableOption "Fira Code symbols";
          package = lib.mkPackageOption pkgs "fira-code-symbols" {};
        };

        config = lib.mkIf cfg.enable {
          fonts.packages = [cfg.package];
        };
      }
    )
  ];
}
