{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        lib,
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkProgram pkgs "foot" {
            name = "foot";
            description = "foot, a fast, lightweight Wayland terminal emulator";
            settings = {
              settings = {
                main = {
                  # term = "xterm-256color";
                  # font = "FiraCode Nerd Font Mono:size=12.5";
                  # shell = "${pkgs.tmux}/bin/tmux new-session -A -s initial";
                };
                mouse.hide-when-typing = "yes";
                bell.visual = "no";
                scrollback.lines = 500;
              };
            };
          })
        ];

        config.desktop.apps.foot.enable = lib.mkDefault false;
      }
    )
  ];
}
