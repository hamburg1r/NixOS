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
            options.desktop.apps.zellij = {
              enable = lib.mkEnableOption "zellij, a terminal workspace and multiplexer";
              package = lib.mkPackageOption pkgs "zellij" {};
            };

            config = lib.mkIf config.desktop.apps.zellij.enable {
              programs.zellij = {
                enable = true;
                package = config.desktop.apps.zellij.package;
                enableBashIntegration = lib.mkDefault config.programs.bash.enable;
                enableZshIntegration = lib.mkDefault config.programs.zsh.enable;
                enableFishIntegration = lib.mkDefault config.programs.fish.enable;
              };
            };
          }
        ];

        config.desktop.apps.zellij.enable = lib.mkDefault true;
      }
    )
  ];
}
