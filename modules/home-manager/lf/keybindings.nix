{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        config,
        lib,
        ...
      }:
        with lib; {
          config = mkIf config.programs.lf.enable {
            programs.lf.keybindings = {
              "~" = "toggle";

              "." = "set hidden!";

              "]" = "move-parent down";
              "[" = "move-parent up";

              d = "";
              dd = "cut";
              dD = "trash";
              do = "dragon-out";
              dm = "$bashmount";

              y = "";
              yy = "copy";
              ya = "cut-add";
              yr = "cut-remove";
              yt = "cut-toggle";

              yd = "yank-dirname";
              yp = "yank-path";
              yn = "yank-basename";
              "y." = "yank-basename-without-extension";

              p = "";
              pp = "paste";
              pl = "link";
              pr = "relative-link";

              gt = "cd /tmp";
              "g/" = "cd /";
              gr = "cd /run";
              gd = "cd ~/repo/NixOS";
              gL = "follow_link";

              c = "";
              cc = "clear";
              cd = "push :mkdir<space>";
            };
          };
        }
    )
  ];
}
