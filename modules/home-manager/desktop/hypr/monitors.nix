{
	config,
	...
}: {
	wayland.windowManager.hyprland.settings = {
		monitor = [
			",preferred,auto,1"
			"eDP-1, 1920x1080, 0x0,1"
			# ""
		];
	};
}
