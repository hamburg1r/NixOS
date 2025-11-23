{
	config,
	...
}: {
    wayland.windowManager.hyprland.settings = {
	input = {
		kb_layout = "us,us,us";
		kb_variant = ",colemak,dvorak";
		# follow_mouse = 2; # or 1
		# mouse_refocus = true;
		numlock_by_default = false;
		touchpad = {
			natural_scroll = false;
			drag_lock = true;
			tap-and-drag = true;
		};
		sensitivity = "0.0";
	};
	gesture = [
		"3, horizontal, workspace"
	];
	device = {
		name = "epic-mouse-v1";
		sensitivity = -0.5;
	};
    };
}
