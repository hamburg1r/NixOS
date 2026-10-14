{...}: {
  config.dendritic.home.common = [
    (
      {
        lib,
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkProgram pkgs "gh" {
            name = "gh";
            description = "the GitHub CLI";
            settings = {
              gitCredentialHelper.enable = lib.mkDefault true;
              settings = {
                git_protocol = lib.mkDefault "ssh";
                editor = lib.mkDefault "nvim";
              };
            };
          })
        ];

        config.desktop.apps.gh.enable = lib.mkDefault true;
      }
    )
  ];
}
