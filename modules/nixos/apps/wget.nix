{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.wget;
      in {
        options.desktop.apps.wget = {
          enable = lib.mkEnableOption "wget";
          package = lib.mkPackageOption pkgs "wget" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
