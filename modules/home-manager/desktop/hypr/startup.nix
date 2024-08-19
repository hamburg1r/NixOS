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
			"${pkgs.stable.easyeffects}/bin/easyeffects"
			"${inputs.fabricConfig.packages.x86_64-linux.default}/bin/desktopEnv &"
			(if config.programs.foot.enable then "foot --server" else "")
		];
		exec = [
			# "ags"
			"${pkgs.swww}/bin/swww-daemon --no-cache"
			"${pkgs.swww}/bin/swww img ${config.wallpaper.desktop.output}"
		];
	};
}
