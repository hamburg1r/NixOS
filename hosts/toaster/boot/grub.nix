{config, ...}: {
  config.dendritic.nixos.toaster = [
    (
      {
        inputs,
        pkgs,
        config,
        lib,
        ...
      }: {
        imports = [inputs.grub2-themes.nixosModules.default];

        # Import is unconditional (imports can't depend on `config`), but none
        # of the theme config is evaluated unless GRUB is actually enabled.
        config = lib.mkIf config.boot.loader.grub.enable {
          wallpaper.grub = {
            dir = "miscellaneous";
            file = "GirlStandingDuskWithBirds.jpg";
          };
          boot.loader.grub2-theme = {
            enable = true;
            theme = "tela";
            icon = "color";
            screen = "1080p";
            splashImage = config.wallpaper.grub.output;
            # bootMenuConfig = ;
            # terminalConfig = ;
            # footer = ;
          };
        };
      }
    )
  ];
}
