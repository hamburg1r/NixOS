{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        mkPkg = spec: let
          name = spec.name;
          pkg = spec.pkg or name;
        in {
          options.desktop.apps.${name} = {
            enable = lib.mkEnableOption name;
            package = lib.mkPackageOption pkgs pkg {};
          };
          config = lib.mkIf config.desktop.apps.${name}.enable {
            environment.systemPackages = [config.desktop.apps.${name}.package];
          };
        };

        nh = config.desktop.apps.nh;
        nix-ld = config.desktop.apps.nix-ld;
      in {
        imports =
          map mkPkg [
            {name = "nix-output-monitor";}
            {name = "nvd";}
          ]
          ++ [
            {
              options.desktop.apps.nh = {
                enable = lib.mkEnableOption "nh, a nix helper CLI";
                package = lib.mkPackageOption pkgs "nh" {};
              };

              config = lib.mkIf nh.enable {
                programs.nh = {
                  enable = true;
                  package = nh.package;
                  clean = {
                    enable = true;
                    extraArgs = "--nogcroots --keep-since 3d --keep 5";
                    dates = "weekly";
                  };
                  # FIXME: change if not this path
                  flake = "/home/hamburgir/repo/NixOS";
                };
              };
            }
            {
              options.desktop.apps.nix-ld = {
                enable = lib.mkEnableOption "nix-ld, for running unpatched dynamic binaries";
                package = lib.mkPackageOption pkgs "nix-ld" {};
              };

              config = lib.mkIf nix-ld.enable {
                programs.nix-ld = {
                  enable = true;
                  package = nix-ld.package;
                  # libraries = pkgs.steam-run.fhsenv.args.multiPkgs pkgs;
                };
              };
            }
          ];
      }
    )
  ];
}
