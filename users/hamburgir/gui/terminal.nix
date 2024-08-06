{
	pkgs,
	...
}: {
	imports = [
		./wezterm
		./kitty
	];
	programs = {
		alacritty = {
			enable = false;
		};
		wezterm = {
			enable = false;
		};
		kitty = {
			enable = true;
		};
		foot = {
			enable = true;
			server.enable = true;
			settings = {
				main = {
					# term = "xterm-256color";
					# font = "FiraCode Nerd Font Mono:size=12.5";
					# shell = "${pkgs.tmux}/bin/tmux new-session -A -s initial";
				};
				mouse = {
					hide-when-typing = "yes";
				};
				bell = {
					visual = "no";
				};
				scrollback = {
					lines = 500;
				};
			};
		};
	};
}
