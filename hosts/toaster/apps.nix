{config, ...}: {
  config.dendritic.nixos.toaster = [
    (
      {...}: {
        desktop.apps = {
          nix-ld.enable = true;
        };
      }
    )
  ];
}
