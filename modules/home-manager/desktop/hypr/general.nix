{
	config,
	...
}: {
	wayland.windowManager.hyprland.settings.general = rec {
		no_border_on_floating = false;

		layout = "dwindle";
		no_focus_fallback = true;
		resize_on_border = true;
		extend_border_grab_area = 6;
		hover_icon_on_border = true;
		allow_tearing = false;
		# resize_corner = 3;
	};
}
