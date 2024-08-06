{
	lib,
	...
}: {
	imports = [
		./kitty
	];
	programs = {
		wezterm = {
			enable = lib.mkDefault false;
		};
	};
}
