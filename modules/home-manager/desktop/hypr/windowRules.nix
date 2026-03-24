{
	pkgs,
	...
}: {
	home.packages = [ pkgs.stable.kdePackages.xwaylandvideobridge ];
	wayland.windowManager.hyprland.settings = {
		windowrule = [
			"opacity 0.0 override, match:class ^(xwaylandvideobridge)$"
			"no_anim on, match:class ^(xwaylandvideobridge)$"
			"no_initial_focus on, match:class ^(xwaylandvideobridge)$"
			"size 1 1, match:class ^(xwaylandvideobridge)$"
			"no_blur on, match:class ^(xwaylandvideobridge)$"
			"no_focus on, match:class ^(xwaylandvideobridge)$"

			"float on, match:class (org.qbittorrent.qBittorrent)"
			"float on, match:class (thunar), match:title (File Operation Progress)"
			"float on, match:class (nemo), match:initial_title !(Home)"

			"move 77% 76%, match:class (firefox), match:title (Picture-in-Picture)"
			"size 22% 22%, match:class (firefox), match:title (Picture-in-Picture)"
			"float on, match:class (firefox), match:title (Picture-in-Picture)"
			"pin on, match:class (firefox), match:title (Picture-in-Picture)"
			"suppress_event fullscreen, match:class (firefox), match:title (Picture-in-Picture)"
			"suppress_event maximize, match:class (firefox), match:title (Picture-in-Picture)"

			"stay_focused on, match:class (polkit-gnome-authentication-agent-1)"
			"pin on, match:class (polkit-gnome-authentication-agent-1)"

			"sync_fullscreen off, match:class (footclient)|(foot)"

			# For some reason first window of foot was opening in 1st workspace
			"workspace e+0, match:class (footclient)|(foot)"

			# "workspace 2, class:(firefox),"

			"workspace 4 silent, match:class (discord)"

			"workspace 4 silent, match:class (vesktop)"

			"workspace 5 silent, match:class (com\\.github\\.th_ch\\.youtube_music)"
			"workspace 5 silent, match:class (YouTube Music Desktop App)"
			"workspace 5 silent, match:class (spotify)"
			"workspace 5 silent, match:class (Spotify)"

			"workspace special:easyeffects silent, match:class (com.github.wwmm.easyeffects)"
		];
	};
}
