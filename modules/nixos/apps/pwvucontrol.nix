{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.pwvucontrol;
      in {
        options.desktop.apps.pwvucontrol = {
          enable = lib.mkEnableOption "pwvucontrol, a PipeWire volume control GUI";
          package = lib.mkPackageOption pkgs "pwvucontrol" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
