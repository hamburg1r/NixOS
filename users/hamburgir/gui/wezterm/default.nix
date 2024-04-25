{
	...
}: {
	# TODO: debug
	programs.wezterm.extraConfig = ''
	------ my conf ------
	local wezterm = require "wezterm"
	local config = {}
	if wezterm.config_builder then
		config = wezterm.config_builder()
	end
	${import ./miscellaneous.nix}
	${import ./ui.nix}
	return config
	------- my conf ------'';
}
