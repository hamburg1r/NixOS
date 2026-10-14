{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        config,
        lib,
        ...
      }:
        with lib; {
          options.programs.niri.customSettings = {
            movement = {
              wrapColumns = mkOption {
                type = types.bool;
                default = true;
                description = "Whether to loop column movement (e.g., focus-column-right-or-first).";
              };
              wrapWindowsAndWorkspaces = mkOption {
                type = types.bool;
                default = true;
                description = "Whether to loop window/workspace movement (e.g., focus-window-or-workspace-down).";
              };
            };
          };
        }
    )
  ];
}
