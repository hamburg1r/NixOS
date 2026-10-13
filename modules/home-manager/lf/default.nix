{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }:
        with lib; {
          config = mkIf config.programs.lf.enable {
            xdg.configFile."lf/icons".source = ./icons;

            programs.lf.package = pkgs.writeShellScriptBin "lf" ''
              set -e

              if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
              	${pkgs.lf}/bin/lf "$@"
              else
              	[ ! -d "$HOME/.cache/lf" ] && mkdir --parents "$HOME/.cache/lf"
              	${pkgs.lf}/bin/lf "$@" 3>&-
              fi
            '';
          };
        }
    )
  ];
}
