{
	pkgs,
	...
}: {
	programs.tmux = {
		clock24 = true;
		plugins = with pkgs.tmuxPlugins; [
			sensible
			yank
			{
				plugin = dracula;
				extraConfig = ''
					set -g @dracula-show-battery false
					set -g @dracula-show-powerline true
					set -g @dracula-refresh-rate 10
					set -g @dracula-plugins "network"
				'';
			}
		];

		extraConfig = ''
			set -g mouse on
		'';
	};
}
