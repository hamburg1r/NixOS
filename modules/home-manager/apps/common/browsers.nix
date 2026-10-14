{config, ...}: {
  config.dendritic.home.common = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports =
          [
            (outputs.lib.mkApp pkgs {
              name = "firefox";
              install = cfg: {
                home.packages = [cfg.package];

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
            })
          ]
          ++ map (outputs.lib.mkHome pkgs) [
            {name = "google-chrome";}
          ];
      }
    )
  ];
}
