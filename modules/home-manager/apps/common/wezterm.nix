{config, ...}: {
  config.dendritic.home.common = [
    (
      {
        lib,
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkProgram pkgs "wezterm" {
            name = "wezterm";
            description = "wezterm, a GPU-accelerated terminal emulator";
          })
        ];

        config.desktop.apps.wezterm.enable = lib.mkDefault false;
      }
    )
  ];
}
