{
	pkgs,
	...
}: {
	# nixpkgs.overlays = [
	# 	inputs.eww.overlays.default
	# 	inputs.rust-overlay.overlays.default
	# ];

	programs = {
		ashell = {
			enable = false;
			settings = {};
		};
		ignis-desktop = {
			enable = false;
		};
	};

	home.packages = with pkgs; [
		swww
		keepassxc
	];
}
