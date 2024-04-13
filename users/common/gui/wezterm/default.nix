{ ... }: {
	programs.wezterm.extraConfig = ''
local wezterm = require "wezterm"
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end
${import ./miscellaneous.nix}
return config'';
}
