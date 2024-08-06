{
	config,
	...
}: {
	wayland.windowManager.hyprland.settings = {
		layerrule = [
			"blur, rofi"
			"xray 1, rofi"
		];
	};
}
