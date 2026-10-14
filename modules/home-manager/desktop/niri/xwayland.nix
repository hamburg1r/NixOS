{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        inputs,
        pkgs,
        lib,
        ...
      }: {
        programs.niri.settings.xwayland-satellite = {
          enable = true;
          path = lib.getExe inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.xwayland-satellite-unstable;
        };
      }
    )
  ];
}
