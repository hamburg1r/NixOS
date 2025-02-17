{
	config,
	...
}: {
	wayland.windowManager.hyprland.settings.general = rec {
		border_size = 2;
		no_border_on_floating = false;

		gaps_in = config.wallpaper.hyprland.gaps.in';
		gaps_out = config.wallpaper.hyprland.gaps.out;
		gaps_workspaces = config.wallpaper.hyprland.gaps.workspaces;

		layout = "dwindle";
		no_focus_fallback = true;
		resize_on_border = true;
		extend_border_grab_area = 6;
		hover_icon_on_border = true;
		allow_tearing = false;
		# resize_corner = 3;
	};
}
