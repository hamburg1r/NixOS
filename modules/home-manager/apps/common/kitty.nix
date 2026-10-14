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
            options.desktop.apps.kitty = {
              enable = lib.mkEnableOption "kitty, a GPU-accelerated terminal emulator";
              package = lib.mkPackageOption pkgs "kitty" {};
            };

            config = lib.mkIf config.desktop.apps.kitty.enable {
              programs.kitty = {
                enable = true;
                package = config.desktop.apps.kitty.package;
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
            };
          }
        ];

        config.desktop.apps.kitty.enable = lib.mkDefault true;
      }
    )
  ];
}
