{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports = map (outputs.lib.mkFont pkgs) [
          {name = "noto-fonts";}
          {name = "noto-fonts-cjk-sans";}
          {name = "noto-fonts-color-emoji";}
          {
            name = "liberation-ttf";
            pkg = "liberation_ttf";
          }
          {name = "fira-code";}
          {name = "fira-code-symbols";}
        ];
      }
    )
  ];
}
