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
          (outputs.lib.mkProgram pkgs "lazygit" {
            name = "lazygit";
            description = "lazygit, a terminal UI for git";
          })
        ];

        config.desktop.apps.lazygit.enable = lib.mkDefault true;
      }
    )
  ];
}
