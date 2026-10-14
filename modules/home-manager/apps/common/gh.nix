{config, ...}: {
  config.dendritic.home.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: {
        imports = [
          {
            options.desktop.apps.gh = {
              enable = lib.mkEnableOption "the GitHub CLI";
              package = lib.mkPackageOption pkgs "gh" {};
            };

            config = lib.mkIf config.desktop.apps.gh.enable {
              programs.gh = {
                enable = true;
                package = config.desktop.apps.gh.package;
                gitCredentialHelper.enable = lib.mkDefault true;
                settings = {
                  git_protocol = lib.mkDefault "ssh";
                  editor = lib.mkDefault "nvim";
                };
              };
            };
          }
        ];

        config.desktop.apps.gh.enable = lib.mkDefault true;
      }
    )
  ];
}
