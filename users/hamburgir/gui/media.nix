{
	pkgs,
	...
}: {
	programs.mpv = {
		enable = true;
		config = {
			target-colorspace-hint = "no";
		};
		scripts = [
			pkgs.mpvScripts.mpris
		];
	};
}
