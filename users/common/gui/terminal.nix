{
	lib,
	...
}: {
	imports = [
		./wezterm
		./kitty
	];
	programs = {
		wezterm = {
			enable = lib.mkDefault true;
		};
	};
}
