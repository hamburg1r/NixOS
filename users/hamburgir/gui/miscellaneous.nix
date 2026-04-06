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
			enable = true;
		};
	};

	home.packages = with pkgs; [
		swww
		keepassxc
	];
}
