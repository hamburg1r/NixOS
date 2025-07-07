{
	pkgs,
	...
}: {
	home.packages = with pkgs; [
		prismlauncher
		gamescope
		lutris
		heroic
		steam
		steam-run
	];
}
