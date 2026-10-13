{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.neovim;
      in {
        options.desktop.apps.neovim = {
          enable = lib.mkEnableOption "neovim";
          package = lib.mkPackageOption pkgs "neovim" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
