{...}: {
  config.dendritic.nixos.common = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports =
          map (outputs.lib.mkSystem pkgs) [
            {name = "nix-output-monitor";}
            {name = "nvd";}
          ]
          ++ [
            (outputs.lib.mkProgram pkgs "nh" {
              name = "nh";
              description = "nh, a nix helper CLI";
              settings = {
                clean = {
                  enable = true;
                  extraArgs = "--nogcroots --keep-since 3d --keep 5";
                  dates = "weekly";
                };
                # FIXME: change if not this path
                flake = "/home/hamburgir/repo/NixOS";
              };
            })
            (outputs.lib.mkProgram pkgs "nix-ld" {
              name = "nix-ld";
              description = "nix-ld, for running unpatched dynamic binaries";
            })
          ];
      }
    )
  ];
}
