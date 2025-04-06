{
	config,
	lib,
	pkgs,
	...
}: with lib; {
	options.theme.enable = mkEnableOption "Enable centralized theme config";

	config = mkIf config.theme.enable {
		home.pointerCursor = {
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
				package = pkgs.dracula-icon-theme;
				name = "Dracula";
			};
			theme = {
				package = pkgs.dracula-theme;
				name = "Dracula";
			};
		};
		qt = {
			enable = true;
			platformTheme.name = "qtct";
			style = {
				package = pkgs.dracula-qt5-theme;
				name = "Dracula";
			};
		};
		fonts.fontconfig = {
			enable = true;
			defaultFonts = {
				emoji = [ config.userTheme.fonts.emoji ];
				monospace = [ config.userTheme.fonts.monospace ];
				sansSerif = [ config.userTheme.fonts.sansSerif ];
				serif = [ config.userTheme.fonts.serif ];
			};
		};

		home.packages = config.userTheme.fonts.packages;

	};
}
