{
	pkgs,
	...
}: {
	home.packages = with pkgs; [
		alsa-utils
		ani-cli
		stable.pamixer
		playerctl
		# ncspot
	];
}
