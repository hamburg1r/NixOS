{config, ...}: {
  config.dendritic.nixos.microwave = [
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
