{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        mkApp = spec: let
          name = spec.name;
          pkg = spec.pkg or name;
        in {
          options.desktop.apps.${name} = {
            enable = lib.mkEnableOption name;
            package = lib.mkPackageOption pkgs pkg {};
          };
          config = lib.mkIf config.desktop.apps.${name}.enable {
            home.packages = [config.desktop.apps.${name}.package];
          };
        };
      in {
        imports =
          map mkApp [
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
            (let
              cfg = config.desktop.apps.mpv;
            in {
              options.desktop.apps.mpv = {
                enable = lib.mkEnableOption "mpv, a media player";
                package = lib.mkPackageOption pkgs "mpv" {};
              };

              config = lib.mkIf cfg.enable {
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
