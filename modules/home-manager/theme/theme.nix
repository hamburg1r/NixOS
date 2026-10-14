{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }:
        with lib; {
          options.theme.enable = mkEnableOption "Enable centralized theme config";

          config = mkIf config.theme.enable {
            home.pointerCursor = {
              enable = true;
              package = config.userTheme.cursors.package;
              gtk.enable = true;
              hyprcursor.enable = config.wayland.windowManager.sway.enable;
              name = config.userTheme.cursors.name;
              size = config.userTheme.cursors.size;
              sway.enable = config.wayland.windowManager.sway.enable;
              x11.enable = true;
            };
            gtk = {
              enable = true;
              iconTheme = {
                package = pkgs.papirus-icon-theme;
                name = "Papirus-Dark";
              };
              theme = {
                package = pkgs.catppuccin-gtk.override {
                  accents = ["blue"];
                  variant = "mocha";
                };
                name = "catppuccin-mocha-blue-standard";
              };
            };
            qt = {
              enable = true;
              platformTheme.name = "gtk3";
            };
            fonts.fontconfig = {
              enable = true;
              defaultFonts = {
                emoji = [config.userTheme.fonts.emoji];
                monospace = [config.userTheme.fonts.monospace];
                sansSerif = [config.userTheme.fonts.sansSerif];
                serif = [config.userTheme.fonts.serif];
              };
            };

            # Fonts are installed by desktop.apps.theme-fonts
            # (modules/home-manager/apps/hamburgir/theme-fonts.nix).
          };
        }
    )
  ];
}
