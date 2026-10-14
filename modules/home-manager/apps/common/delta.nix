{config, ...}: {
  config.dendritic.home.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: {
        imports = [
          {
            options.desktop.apps.delta = {
              enable = lib.mkEnableOption "delta, a syntax-highlighting pager for git";
              package = lib.mkPackageOption pkgs "delta" {};
            };

            config = lib.mkIf config.desktop.apps.delta.enable {
              programs.delta = {
                enable = true;
                package = config.desktop.apps.delta.package;
              };
            };
          }
        ];

        config.desktop.apps.delta.enable = lib.mkDefault true;
      }
    )
  ];
}
