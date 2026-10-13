{config, ...}: {
  config.dendritic.nixos.toaster = [
    (
      {pkgs, ...}: {
        environment.systemPackages = [
          pkgs.devenv
        ];
        programs.direnv = {
          enable = true;
        };
      }
    )
  ];
}
