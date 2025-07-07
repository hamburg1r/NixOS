{
	config,
	pkgs,
	...
}: {
	home.file."Zellij" = {
		enable = config.programs.zellij.enable;
		source = ./zellij;
		target = ".config/zellij";
	};

	programs = {
		tmux = {
			enable = true;
			extraConfig = ''
				set -g allow-passthrough on
			'';
			aggressiveResize = true;
			baseIndex = 1;
			disableConfirmationPrompt = true;
			escapeTime = 0;
			historyLimit = 5000;
			keyMode = "vi";
			mouse = true;
			# newSession = true;
			# plugins = with pkgs; [
			# 	tmuxPlugins.cpu
			# 	{
			# 		plugin = tmuxPlugins.resurrect;
			# 		extraConfig = "set -g @resurrect-strategy-nvim 'session'";
			# 	}
			# 	{
			# 		plugin = tmuxPlugins.continuum;
			# 		extraConfig = ''
			# 			set -g @continuum-restore 'on'
			# 			set -g @continuum-save-interval '60' # minutes
			# 		'';
			# 	}
			# ];
			customPaneNavigationAndResize = true;
			resizeAmount = 1;
			# sensibleOnTop = false;
			shortcut = "Space";
			secureSocket = false;
			terminal = "screen-256color";
			tmuxp.enable = true;
		};
		zellij = {
			enable = true;
			enableBashIntegration = false;
			enableZshIntegration = false;
			enableFishIntegration = false;
		};
	};
}
