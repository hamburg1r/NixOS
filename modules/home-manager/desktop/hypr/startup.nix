{
	inputs,
	config,
	pkgs,
	...
}: {
	wayland.windowManager.hyprland.settings = {
		exec-once = [
			"${pkgs.wl-clipboard}/bin/wl-paste -t image --watch ${pkgs.cliphist}/bin/cliphist store"
			"${pkgs.wl-clipboard}/bin/wl-paste -t text --watch ${pkgs.cliphist}/bin/cliphist store"
			"${pkgs.vesktop}/bin/vesktop"
			# "vesktop"
			# "${pkgs.discord}/bin/discord"
			# "discord"
			"${pkgs.easyeffects}/bin/easyeffects"
			"${inputs.fabricConfig.packages.x86_64-linux.default}/bin/desktopEnv &"
			(if config.programs.foot.enable then "foot --server" else "")
		];
		exec = [
			# "ags"
			"swww-daemon --no-cache"
			"swww img ${config.wallpaper.desktop.output}"
		];
	};
}
