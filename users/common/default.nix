{config, ...}: {
  config.dendritic.home.common = [
    (
      {
        outputs,
        config,
        lib,
        ...
      }: {
        nixpkgs.overlays = [
          outputs.overlays.additions
          outputs.overlays.modifications
          outputs.overlays.stable-packages
          outputs.overlays.unstable-packages
        ];
        home = {
          homeDirectory = lib.mkDefault "/home/${config.home.username}";
          stateVersion = lib.mkDefault "24.05";
        };
        programs.nh = {
          enable = true;
          clean = {
            enable = true;
            extraArgs = "--nogcroots --keep-since 3d --keep 5";
            dates = "daily";
          };
        };
      }
    )
  ];
}
