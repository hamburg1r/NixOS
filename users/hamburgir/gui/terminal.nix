{
	...
}: {
	imports = [
		./wezterm
		./kitty
	];
	programs = {
		wezterm = {
			enable = true;
		};
		kitty = {
			enable = true;
		};
	};
}
