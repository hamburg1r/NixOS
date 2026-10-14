{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        lib,
        pkgs,
        outputs,
        ...
      }: let
        mkSystem = outputs.lib.mkSystem pkgs;
      in {
        imports =
          map mkSystem [
            {name = "git";}
            {name = "wget";}
            {name = "ripgrep";}
            {name = "fd";}
            {name = "lf";}
            {name = "trash-cli";}
            {name = "unzip";}
            {name = "unrar";}
            {name = "lz4";}
            {name = "neovim";}
          ]
          ++ [
            (outputs.lib.mkProgram pkgs "mtr" {
              name = "mtr";
              description = "mtr, a network diagnostic tool";
              enable = lib.mkDefault true;
            })
          ];
      }
    )
  ];
}
