{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        config,
        inputs,
        lib,
        outputs,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.niri;
      in {
        options.desktop.apps.niri = {
          enable = lib.mkEnableOption "niri, a scrollable-tiling Wayland compositor";
          package = lib.mkOption {
            type = lib.types.package;
            default = outputs.lib.niri.forceRenderPackage inputs pkgs;
            defaultText = lib.literalExpression "outputs.lib.niri.forceRenderPackage inputs pkgs";
            description = "The niri package to install.";
          };
        };

        config = lib.mkIf cfg.enable {
          programs.niri = {
            enable = true;
            package = cfg.package;
          };
        };
      }
    )
  ];
}
