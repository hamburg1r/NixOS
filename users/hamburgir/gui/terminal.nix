{...}: {
  config.dendritic.home.hamburgir = [
    (
      {...}: {
        programs = {
          alacritty = {
            enable = false;
          };
          foot = {
            enable = false;
            settings = {
              main = {
                # term = "xterm-256color";
                # font = "FiraCode Nerd Font Mono:size=12.5";
                # shell = "${pkgs.tmux}/bin/tmux new-session -A -s initial";
              };
              mouse = {
                hide-when-typing = "yes";
              };
              bell = {
                visual = "no";
              };
              scrollback = {
                lines = 500;
              };
            };
          };
        };
      }
    )
  ];
}
