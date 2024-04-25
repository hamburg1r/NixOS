{
	config,
	...
}: {
	wayland.windowManager.hyprland.settings = {
		general.layout = "dwindle";
		misc = {
			disable_hyprland_logo = true;
			disable_splash_rendering = true;
			# force_hypr_chan = false;
			force_default_wallpaper = 0;
		};
		binds = {
			workspace_back_and_forth = true;
		};
	};
}
