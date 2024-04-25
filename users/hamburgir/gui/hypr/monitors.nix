{
	config,
	...
}: {
	wayland.windowManager.hyprland.settings = {
		monitor = [
			",preferred,auto,1"
			 "eDP-1,preferred,auto,1"
		];
	};
}
