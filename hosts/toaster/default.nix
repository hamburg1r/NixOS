{config, ...}: {
  config.dendritic.nixos.toaster = [
    (
      {
        outputs,
        pkgs,
        ...
      }: {
        programs.nix-ld = {
          enable = true;
        };
      }
    )
  ];
}
