{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.crosspipe;
      in {
        options.desktop.apps.crosspipe = {
          enable = lib.mkEnableOption "crosspipe, for PipeWire audio routing";
          package = lib.mkPackageOption pkgs "crosspipe" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
