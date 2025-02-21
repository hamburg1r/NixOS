{
	pkgs,
	lib,
	config,
	...
}: let
	inherit (lib) mkOption;
	inherit (lib.types) submodule enum listOf str bool int;
	inherit (lib.nvim.types) luaInline mkPluginSetupOption;
	inherit (lib.generators) mkLuaInline;
in {
	options.vim.autosave.nvim = {
		setupOpts = mkPluginSetupOption "autosave" {
			enable = mkOption {
				type = bool;
				default = true;
				description = "Enable autosave at startup.";
			};
			prompt = mkOption {
				type = submodule {
					options = {
						enable = mkOption {
							type = bool;
							default = true;
							description = "Prompt when saved.";
						};
						style = mkOption {
							default = if ( config.vim.notify.nvim-notify.enable or config.vim.mini.notify.enable ) then "notify" else "stdout";
							type = enum [ "stdout" "notify" ];
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
				default = {};
			};
			events = mkOption {
				default = [ "InsertLeave" "TextChanged" ];
				type = listOf str;
				description = "events that will trigger the plugin.";
			};
			conditions = mkOption {
				type = submodule {
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
				default = {};
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
		autosave.nvim.setupOpts = {
			prompt.enable = false;
		};

		lazy.plugins = {
			${pkgs.vimPlugins.autosave.pname} = {
				package = pkgs.vimPlugins.autosave;
				# package = "autosave-nvim";
				setupModule = "autosave";
				inherit (config.vim.autosave.nvim) setupOpts;
				event = [ "InsertLeave" "TextChanged" ];
				cmd = [
					"ASToggle"
					"ASEnable"
					"ASDisable"
				];
			};
		};
		utility	= {
		# 	new-file-template = {
		# 		enable = true;
		# 	};
			images.image-nvim = {
				enable = true;
				setupOpts.backend = "kitty";
			};
			leetcode-nvim = {
				enable = true;
				setupOpts = {
					image_support = true;
				};
			};
		};
	};
}
