{
	config,
	...
}: {
	wayland.windowManager.hyprland = {
		enable = true;
	};
	programs.niri.enable = true;
}
