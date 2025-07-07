{
	pkgs,
	...
}: {
	services.tumbler.enable = true;
	environment.systemPackages = with pkgs; [
		vulkan-loader
		vulkan-tools
		mpv
		ffmpegthumbnailer
		gparted
		zenity
		# dunst
		libnotify
		# poppler
		nemo
		# xfce.thunar
		xfce.ristretto
		## xorg
		# xclip
		# xdotool
		## wayland
		wl-clipboard
		# wtype
		ydotool
		firefox
	];
}
