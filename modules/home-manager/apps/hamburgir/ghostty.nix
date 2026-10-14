{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        config,
        lib,
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkProgram pkgs "ghostty" {
            name = "ghostty";
            description = "ghostty, a GPU-accelerated terminal emulator";
            settings = {
              enableBashIntegration = config.programs.bash.enable;
              enableZshIntegration = config.programs.zsh.enable;
              enableFishIntegration = config.programs.fish.enable;
              settings = {
                font-family = "FiraCode Nerd Font Mono";
                palette = [
                  "0=#21222c"
                  "1=#ff5555"
                  "2=#50fa7b"
                  "3=#f1fa8c"
                  "4=#bd93f9"
                  "5=#ff79c6"
                  "6=#8be9fd"
                  "7=#f8f8f2"
                  "8=#6272a4"
                  "9=#ff6e6e"
                  "10=#69ff94"
                  "11=#ffffa5"
                  "12=#d6acff"
                  "13=#ff92df"
                  "14=#a4ffff"
                  "15=#ffffff"
                ];
                background = "#282a36";
                foreground = "#f8f8f2";
                cursor-color = "#f8f8f2";
                cursor-text = "#282a36";
                selection-foreground = "#f8f8f2";
                selection-background = "#44475a";
              };
            };
          })
        ];

        config.desktop.apps.ghostty.enable = lib.mkDefault true;
      }
    )
  ];
}
