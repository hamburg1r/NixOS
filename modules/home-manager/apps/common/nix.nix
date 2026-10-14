{...}: {
  config.dendritic.home.common = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkProgram pkgs "nh" {
            name = "nh";
            description = "nh, a nix helper CLI";
            settings.clean = {
              enable = true;
              extraArgs = "--nogcroots --keep-since 3d --keep 5";
              dates = "daily";
            };
          })
        ];
      }
    )
  ];
}
