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
          google-chrome.enable = lib.mkForce false;
        };
      }
    )
  ];
}
