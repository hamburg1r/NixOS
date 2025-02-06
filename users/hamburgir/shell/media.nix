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
	];
}
