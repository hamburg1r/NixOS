# TODO: remove mkForce
{
	config,
	lib,
	...
}: let
	cfg = config.wallpaper.hyprland;
in {
	wayland.windowManager.hyprland.settings = {
		general = {
			gaps_in = lib.mkForce cfg.gaps.in';
			gaps_out = lib.mkForce cfg.gaps.out;
			gaps_workspaces = lib.mkForce cfg.gaps.workspaces;

			"col.inactive_border" = lib.mkForce "rgb(1e1e2e)";
			"col.active_border" = lib.mkForce "rgb(89b4fa)";
			"col.nogroup_border" = lib.mkForce "rgb(11111b)";
		};
		decoration = {
			inherit (cfg) rounding;
			active_opacity = cfg.opacity.active;
			inactive_opacity = cfg.opacity.inactive;
			fullscreen_opacity = 1.0;
			dim_inactive = cfg.dim.enable;
			dim_strength = cfg.dim.strength;
			dim_special = cfg.dim.special;
			dim_around = cfg.dim.around;

			blur = let
				cfg' = cfg.blur;
			in {
				inherit (cfg')
					enabled
					size
					passes
					noise
					contrast
					brightness
					vibrancy
					vibrancy_darkness;
				# ignore_opacity = false;
				xray = false;
				special = false;
				popups = false;
			};

			shadow = {
				enabled = true;
				range = 5; # TODO
				render_power = 1; # TODO
				sharp = false; # TODO
				ignore_window = true;
				# color = ; # TODO
				# color_inactive = ; # TODO
				# offset = [ 0 0 ]; # TODO
				# scale = 1.0;
			};
		};
		animations = {
			enabled = true;
			first_launch_animation = true;
		};
	};
}
