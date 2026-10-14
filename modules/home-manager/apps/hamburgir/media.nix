{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports =
          map (outputs.lib.mkHome pkgs) [
            {name = "crosspipe";}
            {name = "qbittorrent";}
            {name = "peazip";}
            {name = "alsa-utils";}
            {name = "ani-cli";}
            {
              name = "pamixer";
              pkg = ["stable" "pamixer"];
            }
            {name = "playerctl";}
          ]
          ++ [
            (outputs.lib.mkApp pkgs {
              name = "mpv";
              description = "mpv, a media player";
              install = cfg: {
                home.packages = [cfg.package];
                programs.mpv = {
                  enable = true;
                  bindings = {
                    LEFT = "seek -5";
                    RIGHT = "seek 5";
                  };
                  config = {
                    target-colorspace-hint = "no";
                  };
                  scripts = [pkgs.mpvScripts.mpris];
                };
              };
            })
          ];
      }
    )
  ];
}
