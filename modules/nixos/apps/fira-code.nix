{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.fira-code;
      in {
        options.desktop.apps.fira-code = {
          enable = lib.mkEnableOption "the Fira Code font";
          package = lib.mkPackageOption pkgs "fira-code" {};
        };

        config = lib.mkIf cfg.enable {
          fonts.packages = [cfg.package];
        };
      }
    )
  ];
}
