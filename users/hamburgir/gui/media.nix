{
	pkgs,
	...
}: {
	programs.mpv = {
		enable = true;
		bindings = {
			LEFT = "seek -5";
			RIGHT = "seek 5";
		};
		config = {
			target-colorspace-hint = "no";
		};
		scripts = [
			pkgs.mpvScripts.mpris
		];
	};

	home.packages = with pkgs; [
		crosspipe
	];
}
