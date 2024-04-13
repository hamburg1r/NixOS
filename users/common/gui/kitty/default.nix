{
	config,
	lib,
	...
}: {
	programs.kitty = {
		shellIntegration = {
			enableBashIntegration = lib.mkDefault config.programs.bash.enable;
			enableZshIntegration = lib.mkDefault config.programs.zsh.enable;
			enableFishIntegration = lib.mkDefault config.programs.fish.enable;
		};
		settings = {
			background_image = "null";
			enable_audio_bell = false;
			cursor_shape = "block";
		};
	};
}
