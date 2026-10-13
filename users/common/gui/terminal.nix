{config, ...}: {
  config.dendritic.home.common = [
    (
      {lib, ...}: {
        programs = {
          wezterm = {
            enable = lib.mkDefault false;
          };
        };
      }
    )
  ];
}
