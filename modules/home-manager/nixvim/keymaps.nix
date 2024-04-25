{ ... }: {
	programs.nixvim.keymaps = let
		vimCmd = (cmd: "<CMD>${cmd}<CR>");
		lldr = (key: "<LocalLeader>${key}");
		ldr = (key: "<Leader>${key}");
		bgrp = (key: ldr "b${key}");
		fgrp = (key: ldr "f${key}");
		ogrp = (key: ldr "o${key}");
		tgrp = (key: ldr "t${key}");
	in [
		{
			action = "<Nop>";
			key = "<space>";
			mode = [ "n" ];
			options = {
				silent = true;
			};
		}
		# Buffers
		{
			action = vimCmd "bprevious";
			key = bgrp "h";
			mode = [ "n" ];
			options = {
				desc = "Cycle to previous buffer";
				silent = true;
			};
		}
		{
			action = vimCmd "bnext";
			key = bgrp "l";
			mode = [ "n" ];
			options = {
				desc = "Cycle to next buffer";
				silent = true;
			};
		}
		{
			action = vimCmd "edit";
			key = bgrp "r";
			mode = [ "n" ];
			options = {
				desc = "Reload current buffer";
				silent = true;
			};
		}
		{
			action = vimCmd "edit!";
			key = bgrp "R";
			mode = [ "n" ];
			options = {
				desc = "Force reload current buffer";
				silent = true;
			};
		}
		# Files
		{
			action = "require('telescope.builtin').grep_string";
			lua = true;
			key = fgrp "G";
			mode = [ "n" "v" ];
			options = {
				desc = "Grep string under cursor in pwd";
                silent = true;
			};
		}
		# Open
		{
			action = vimCmd "Oil";
			key = ogrp "e";
			mode = [ "n" ];
			options = {
				desc = "Open split explorer";
				silent = true;
			};
		}
		{
			action = vimCmd "NvimTreeFocus";
			key = ogrp "t";
			mode = [ "n" ];
			options = {
				desc = "Open project viewer";
				silent = true;
			};
		}
		# Toggle
		{
			action = vimCmd "noh";
			key = tgrp "h";
			mode = [ "n" ];
			options = {
				desc = "Toggle search highlight";
				silent = true;
			};
		}
		# Misc
		{
			action = vimCmd "edit <cfile>";
			key = ldr "gf";
			mode = [ "n" "v" ];
			options = {
				desc = "Open non existent file";
				silent = true;
			};
		}
	];

	programs.nixvim.plugins.which-key = {
		enable = true;
		layout = {
			align = "center";
		};
		operators = {
			gc = "Comments";
		};
		registrations = {
			"<Leader>;" = "Neovim";
			"<Leader>/" = "+Lost Something?";
			"<Leader>b" = "Buffers";
			"<Leader>t" = "Toggle";
		};
	};
}
