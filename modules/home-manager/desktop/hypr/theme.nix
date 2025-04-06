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
		};
		decoration = {
			inherit (cfg) rounding;
			# active_opacity = cfg.opacity.active;
			# inactive_opacity = cfg.opacity.inactive;
			# fullscreen_opacity = 1.0;
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

		};
		animations = {
			enabled = true;
			first_launch_animation = true;
		};
	};
}
