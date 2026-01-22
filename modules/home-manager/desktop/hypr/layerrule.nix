{
	config,
	...
}: {
	wayland.windowManager.hyprland.settings = {
		# Currently broken also unused
		layerrule = [
			# "blur, rofi"
			# "xray 1, rofi"
		];
	};
}
