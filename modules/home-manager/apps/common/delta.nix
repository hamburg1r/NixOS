{config, ...}: {
  config.dendritic.home.common = [
    (
      {
        lib,
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkProgram pkgs "delta" {
            name = "delta";
            description = "delta, a syntax-highlighting pager for git";
          })
        ];

        config.desktop.apps.delta.enable = lib.mkDefault true;
      }
    )
  ];
}
