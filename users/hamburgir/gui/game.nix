{
	pkgs,
	...
}: {
	home.packages = with pkgs; [
		prismlauncher
		gamescope
		lutris
		steam
	]
}
