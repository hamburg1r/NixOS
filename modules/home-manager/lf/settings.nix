{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        config,
        lib,
        ...
      }:
        with lib; {
          config = mkIf config.programs.lf.enable {
            programs.lf.settings = {
              preview = true;
              # hidden = true;
              drawbox = true;
              icons = true;
              ignorecase = true;
              period = 1;
              # ratios = [1 2 3 5];
              tabstop = 4;
              # on-quit
              sixel = true;
            };
          };
        }
    )
  ];
}
