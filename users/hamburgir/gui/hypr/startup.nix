{
	config,
	pkgs,
	...
}: {
	wayland.windowManager.hyprland.settings = {
		exec-once = [
			"${pkgs.wl-clipboard}/bin/wl-paste -t image --watch ${pkgs.cliphist}/bin/cliphist store"
			"${pkgs.wl-clipboard}/bin/wl-paste -t text --watch ${pkgs.cliphist}/bin/cliphist store"
			"discord"
		];
		exec = [
			"ags"
			"swww init; swww img ${config.wallpaper.desktop.output}"
		];
	};
}
