{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        virt-manager = config.desktop.apps.virt-manager;
      in {
        imports =
          [
            {
              options.desktop.apps.virt-manager = {
                enable = lib.mkEnableOption "virt-manager, a virtual machine manager";
                package = lib.mkPackageOption pkgs "virt-manager" {};
              };

              config = lib.mkIf virt-manager.enable {
                programs.virt-manager = {
                  enable = true;
                  package = virt-manager.package;
                };
              };
            }
          ]
          ++ (let
            mkPkg = spec: let
              name = spec.name;
              pkg = spec.pkg or name;
            in {
              options.desktop.apps.${name} = {
                enable = lib.mkEnableOption name;
                package = lib.mkPackageOption pkgs pkg {};
              };
              config = lib.mkIf config.desktop.apps.${name}.enable {
                environment.systemPackages = [config.desktop.apps.${name}.package];
              };
            };
          in
            map mkPkg [
              {name = "distrobox";}
            ]);
      }
    )
  ];
}
