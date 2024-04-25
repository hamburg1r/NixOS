{
	config,
	...
}: {
    wayland.windowManager.hyprland.settings = {
		input = {
			kb_layout = "us";
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
		gestures = {
			workspace_swipe = true;
		};
		device = {
			name = "epic-mouse-v1";
			sensitivity = -0.5;
		};
    };
}
