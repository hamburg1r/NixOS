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
          (outputs.lib.mkProgram pkgs "kitty" {
            name = "kitty";
            description = "kitty, a GPU-accelerated terminal emulator";
            settings = {
              shellIntegration = {
                enableBashIntegration = lib.mkDefault config.programs.bash.enable;
                enableZshIntegration = lib.mkDefault config.programs.zsh.enable;
                enableFishIntegration = lib.mkDefault config.programs.fish.enable;
              };
              settings = {
                enable_audio_bell = false;
                cursor_shape = "block";
              };
            };
          })
        ];

        config.desktop.apps.kitty.enable = lib.mkDefault true;
      }
    )
  ];
}
