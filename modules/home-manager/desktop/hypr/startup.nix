{
	inputs,
	config,
	pkgs,
	lib,
	...
}: {
	wayland.windowManager.hyprland.settings = {
		exec-once = lib.concatLists [
			[
				"xwaylandvideobridge"
				"${pkgs.wl-clipboard}/bin/wl-paste -t image --watch ${pkgs.cliphist}/bin/cliphist store"
				"${pkgs.wl-clipboard}/bin/wl-paste -t text --watch ${pkgs.cliphist}/bin/cliphist store"

				# "${pkgs.vesktop}/bin/vesktop"
				# "vesktop"
				# "${pkgs.discord}/bin/discord"
				"discord"

				"${pkgs.stable.easyeffects}/bin/easyeffects"

				# "${inputs.fabricConfig.packages.x86_64-linux.default}/bin/desktopEnv &"
			]
			(lib.optionals config.programs.waybar.enable ["waybar"])
			(lib.optionals config.programs.foot.enable ["foot --server"])
			[
				# "spotify --enable-features=UseOzonePlatform --ozone-platform=wayland"
				"ytmdesktop"
			]
		];
		exec = lib.concatLists [
			[
				# "ags"
			]
			(lib.optionals config.programs.ignis-desktop.enable ["ignis-desktop"])
			[
				"${pkgs.awww}/bin/awww-daemon --no-cache"
				"${pkgs.awww}/bin/awww restore"
				# "${pkgs.awww}/bin/awww img ${config.wallpaper.desktop.output}"
			]
		];
	};
}
