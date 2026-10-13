{config, ...}: {
  config.dendritic.home.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.nh;
      in {
        options.desktop.apps.nh = {
          enable = lib.mkEnableOption "nh, a nix helper CLI";
          package = lib.mkPackageOption pkgs "nh" {};
        };

        config = lib.mkIf cfg.enable {
          programs.nh = {
            enable = true;
            package = cfg.package;
            clean = {
              enable = true;
              extraArgs = "--nogcroots --keep-since 3d --keep 5";
              dates = "daily";
            };
          };
        };
      }
    )
  ];
}
