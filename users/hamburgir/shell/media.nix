{
	pkgs,
	...
}: {
	home.packages = with pkgs; [
		alsa-utils
		ani-cli
		pamixer
		playerctl
		# ncspot
		spotify-cli-linux
		spotifyd
		spotify
	];
}
