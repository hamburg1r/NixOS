{
	pkgs,
	lib,
	config,
	...
}: let
	inherit (lib.types) submodule mkOption mkEnableOption oneOf listOf str bool int;
	inherit (lib.nvim.types) luaInline mkPluginSetupOption;
	inherit (lib.generators) mkLuaInline;
in {
	options.vim.autosave = {
		setupOpts = mkPluginSetupOption "autosave" {
			enable = mkEnableOption "Enable autosave at startup." true;
			prompt = submodule {
				options = {
					enable = mkEnableOption "Prompt when saved" true;
					style = mkOption {
						default = if ( config.vim.notify.nvim-notify.enable or config.vim.mini.notify.enable ) then "notify" else "stdout";
						type = oneOf [ "stdout" "notify" ];
						description = "Prompt type";
					};
					message = mkOption {
						default = mkLuaInline ''
						function()
							return 'Autosave: saved at ' .. vim.fn.strftime('%H:%M:%S')
						end
						'';
						type = luaInline;
						description = "Message to print after saving";
					};
				};
			};
			events = mkOption {
				default = [ "InsertLeave" "TextChanged" ];
				type = listOf str;
				description = "events that will trigger the plugin.";
			};
			conditions = submodule {
				options = {
					exists = mkOption {
						default = true;
						type = bool;
						description = "if true, enables this condition. If the file doesn't exist it won't save it (e.g. if you nvim stuff.txt and don't save the file then this condition won't be met)";
					};
					modifiable = mkOption {
						default = true;
						type = bool;
						description = "if true, enables this condition. If the file isn't modifiable, then this condition isn't met.";
					};
					filename_is_not = mkOption {
						default = [];
						type = listOf str;
						description = "if there is one or more filenames (should be array) in the table, it enables this condition. Use this to exclude filenames that you don't want to automatically save.";
					};
					filetype_is_not = mkOption {
						default = [];
						type = listOf str;
						description = "if there is one or more filetypes (should be array) in the table, it enables this condition. Use this to exclude filetypes that you don't want to automatically save.";
					};
				};
			};
			write_all_buffers = mkOption {
				default = false;
				type = bool;
				description = "if true, writes to all modifiable buffers that meet the conditions.";
			};
			debounce_delay = mkOption {
				default = 135;
				type = int;
				description = "if greater than 0, saves the file at most every debounce_delay milliseconds, vastly improving editing performance. If 0 then saves are performed immediately after events occur. It's recommend to leave the default value (135), which is just long enough to reduce unnecessary saves, but short enough that you don't notice the delay.";
			};
		};
	};
	config.vim = {
		autopairs = {
			nvim-autopairs.enable = true;
		};
		binds.whichKey = {
			enable = true;
			register = {};
			# setupOpts.preset = "modern"; # "classic" "helix"
		};
		comments.comment-nvim = {
			enable = true;
			setupOpts = {
				padding = true;
				sticky = true;
				mappings = {
					basic = true;
					extra = true;
				};
			};
		};

		# lazy.plugins = {
		# 	autosave = {
		# 		# package = pkgs.vimPlugins.autosave;
		# 		package = "autosave";
		# 		setupModule = "autosave";
		# 		inherit (config.vim.autosave) setupOpts;
		# 		event = [ "InsertLeave" ];
		# 		cmd = [
		# 			"ASToggle"
		# 			"ASEnable"
		# 			"ASDisable"
		# 		];
		# 	};
		# };
		# luaConfigRC = lib.nvim.dag.entryAnywhere ''
		# 	require('autosave').setup(${lib.nvim.lua.toLuaObject config.vim.autosave.setupOpts})
		# '';
	};
}
