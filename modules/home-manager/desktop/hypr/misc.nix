{
	...
}: {
	wayland.windowManager.hyprland = {
		extraConfig = ''
submap = specialWorkspaces
bind = , e, togglespecialworkspace, easyeffects
bind = , e, submap, reset
bind = , t, togglespecialworkspace, terminal
bind = , t, submap, reset
bind = , escape, submap, reset
submap = reset
		'';
	settings = {
		general = {
			gaps_in = 4;
			gaps_out = 8;
		};
		general.layout = "dwindle";
		misc = {
			disable_hyprland_logo = true;
			disable_splash_rendering = true;
			# force_hypr_chan = false;
			force_default_wallpaper = 0;
		};
		binds = {
			workspace_back_and_forth = true;
		};
	};
	};
}
