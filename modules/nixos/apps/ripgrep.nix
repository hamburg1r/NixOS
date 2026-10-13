{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.ripgrep;
      in {
        options.desktop.apps.ripgrep = {
          enable = lib.mkEnableOption "ripgrep";
          package = lib.mkPackageOption pkgs "ripgrep" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
