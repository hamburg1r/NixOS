{
	config,
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
		ghostty = {
			enable = true;
			enableBashIntegration = config.programs.bash.enable;
			enableZshIntegration = config.programs.zsh.enable;
			enableFishIntegration = config.programs.fish.enable;
		};
		foot = {
			enable = false;
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
