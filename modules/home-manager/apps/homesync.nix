{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        inputs,
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.homesync;
      in {
        options.desktop.apps.homesync = {
          enable = lib.mkEnableOption "homesync-server";
          package = lib.mkOption {
            type = lib.types.package;
            default = inputs.homesync.packages.${pkgs.system}.homesync-server;
            defaultText = lib.literalExpression "inputs.homesync.packages.\${pkgs.system}.homesync-server";
            description = "The homesync-server package to install.";
          };
        };

        config = lib.mkIf cfg.enable {
          home.packages = [cfg.package];
        };
      }
    )
  ];
}
