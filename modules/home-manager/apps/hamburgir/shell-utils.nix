{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports =
          map (outputs.lib.mkHome pkgs) [
            {name = "sshfs";}
          ]
          ++ [
            (outputs.lib.mkProgram pkgs "lf" {
              name = "lf";
              description = "lf, a terminal file manager";
              usePackage = false;
            })
            (outputs.lib.mkProgram pkgs "aria2" {
              name = "aria2";
              description = "aria2, a download utility";
            })
            (outputs.lib.mkProgram pkgs "bashmount" {
              name = "bashmount";
              description = "bashmount, a menu-driven block device mounter";
            })
            (outputs.lib.mkProgram pkgs "taskwarrior" {
              name = "taskwarrior";
              pkg = "taskwarrior3";
              description = "taskwarrior, a command-line TODO list manager";
            })
          ];
      }
    )
  ];
}
