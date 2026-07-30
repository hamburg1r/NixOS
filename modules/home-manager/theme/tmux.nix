{
	pkgs,
	...
}: {
	programs.tmux = {
		clock24 = true;
		plugins = with pkgs.tmuxPlugins; [
			sensible
			yank

		];

		extraConfig = ''
			set -g mouse on
		'';
	};
}
