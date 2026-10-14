{config, ...}: {
  config.dendritic.home.common = [
    (
      {
        config,
        lib,
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkProgram pkgs "zellij" {
            name = "zellij";
            description = "zellij, a terminal workspace and multiplexer";
            settings = {
              enableBashIntegration = lib.mkDefault config.programs.bash.enable;
              enableZshIntegration = lib.mkDefault config.programs.zsh.enable;
              enableFishIntegration = lib.mkDefault config.programs.fish.enable;
            };
          })
        ];

        config.desktop.apps.zellij.enable = lib.mkDefault true;
      }
    )
  ];
}
