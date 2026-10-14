{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        config,
        lib,
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkProgram pkgs "atuin" {
            name = "atuin";
            description = "atuin, a shell history sync tool";
            enable = false;
            settings = {
              settings = {
                auto_sync = true;
                update_check = false;
                sync_frequency = "10m";
                search_mode = "fuzzy";
                filter_mode = "global";
                exit_mode = "return-original";
              };
            };
          })
        ];

        config.desktop.apps.atuin.enable = lib.mkDefault false;
      }
    )
  ];
}
