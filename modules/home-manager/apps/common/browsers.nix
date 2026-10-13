{config, ...}: {
  config.dendritic.home.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        firefox = config.desktop.apps.firefox;
        mkPkg = spec: let
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
          [
            {
              options.desktop.apps.firefox = {
                enable = lib.mkEnableOption "firefox";
                package = lib.mkPackageOption pkgs "firefox" {};
              };

              config = lib.mkIf firefox.enable {
                home.packages = [firefox.package];

                # The Home Manager firefox module is kept disabled; firefox is
                # installed as a plain package instead. Profile settings below
                # are preserved for when it is turned back on.
                programs.firefox = {
                  enable = false;
                  profiles.hamburgir = {
                    isDefault = true;
                    search = {
                      engines = {
                        "Google" = {
                          urls = [
                            {
                              template = "https://google.com";
                              params = [
                                {
                                  name = "q";
                                  value = "{searchTerms}";
                                }
                              ];
                            }
                          ];

                          icon = "";
                          definedAlias = ["@g"];
                        };
                        "Nix Options" = {
                          urls = [
                            {
                              template = "https://search.nixos.org/options";
                              params = [
                                {
                                  name = "type";
                                  value = "packages";
                                }
                                {
                                  name = "query";
                                  value = "{searchTerms}";
                                }
                              ];
                            }
                          ];

                          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                          definedAlias = ["@no"];
                        };
                        "Nix Packages" = {
                          urls = [
                            {
                              template = "https://search.nixos.org/packages";
                              params = [
                                {
                                  name = "type";
                                  value = "packages";
                                }
                                {
                                  name = "query";
                                  value = "{searchTerms}";
                                }
                              ];
                            }
                          ];

                          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                          definedAlias = ["@np"];
                        };
                      };
                      force = true;
                    };
                  };
                };
              };
            }
          ]
          ++ map mkPkg [
            {name = "google-chrome";}
          ];
      }
    )
  ];
}
