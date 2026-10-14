{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        lib,
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkProgram pkgs "broot" {
            name = "broot";
            description = "broot, a tree view filesystem navigator";
            enable = true;
          })
        ];

        config.desktop.apps.broot.enable = lib.mkDefault true;
      }
    )
  ];
}
