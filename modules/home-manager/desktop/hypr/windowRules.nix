{
	...
}: {
	wayland.windowManager.hyprland.settings = {
		windowrulev2 = [
			"float, class:(org.qbittorrent.qBittorrent), title:^(?!qBittorrent)(.*)"
			"float, class:(thunar), title:(File Operation Progress)"

			"move 77% 76%, class:(firefox), title:(Picture-in-Picture)"
			"size 22% 22%, class:(firefox), title:(Picture-in-Picture)"
			"float, class:(firefox), title:(Picture-in-Picture)"
			"pin, class:(firefox), title:(Picture-in-Picture)"
			"suppressevent fullscreen, class:(firefox), title:(Picture-in-Picture)"
			"suppressevent maximize, class:(firefox), title:(Picture-in-Picture)"

			"stayfocused, class:(polkit-gnome-authentication-agent-1)"
			"pin, class:(polkit-gnome-authentication-agent-1)"

			"workspace e+0, class:(footclient)|(foot),"

			"workspace 2, class:(firefox),"

			"workspace 4 silent, class:(discord),"

			"workspace 4 silent, class:(vesktop),"

			"workspace 5 silent, class:(Spotify),"

			"workspace special:easyeffects silent, class:(com.github.wwmm.easyeffects),"
		];
	};
}
