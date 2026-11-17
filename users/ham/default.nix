{...}: {
  config.dendritic.home.ham = [
    (
      {lib, pkgs, ...}: {
        home = {
          username = "ham";
          sessionPath = ["$HOME/.local/bin"];
          sessionVariables = {
            EDITOR = "nvim";
            TERMINAL = "foot";
          };
          packages = [pkgs.foot pkgs.tigervnc];
        };

        # Keep the desktop look, editor and terminal workflow, not the full
        # gaming/development/social app collection from hamburgir.
        desktop.apps = {
          nixvim.enable = true;
          niri.enable = true;
          tmux.enable = true;
          zellij.enable = lib.mkForce false;
          google-chrome.enable = lib.mkForce false;
        };

        # Enter tmux only when running `tmux`, never on shell startup.
        programs.tmux.newSession = false;
      }
    )
  ];
}
