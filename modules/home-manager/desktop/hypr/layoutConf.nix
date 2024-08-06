{
	...
}: {
	wayland.windowManager.hyprland.settings = {
		dwindle = {
			# no_gaps_when_only = true;
			pseudotile = "yes";
			preserve_split = "yes"; # you probably want this
		};

		master = {
			# no_gaps_when_only = true;
			new_status = "slave";
		};
	};
}
