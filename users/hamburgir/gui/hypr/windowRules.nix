{
	config,
	...
}: {
	wayland.windowManager.hyprland.settings = {
		windowrulev2 = [
			"move 77% 76%, class:(firefox), title:(Picture-in-Picture)"
			"size 22% 22%, class:(firefox), title:(Picture-in-Picture)"
			"float, class:(firefox), title:(Picture-in-Picture)"
			"pin, class:(firefox), title:(Picture-in-Picture)"
			"suppressevent fullscreen, class:(firefox), title:(Picture-in-Picture)"
			"suppressevent maximize, class:(firefox), title:(Picture-in-Picture)"

			"workspace 2, class:(firefox),"
			"workspace 4, class:(discord),"
		];
	};
}
