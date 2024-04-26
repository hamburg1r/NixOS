{
	...
}: {
	imports = [
		./wezterm
		./kitty
	];
	programs = {
		alacritty = {
			enable = true;
		};
		wezterm = {
			enable = true;
		};
		kitty = {
			enable = true;
		};
	};
}
