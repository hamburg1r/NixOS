{ ... }: {
	programs.nixvim.plugins.telescope = {
		enable = true;
		keymaps = {
			"<Leader>bs" = {
				action = "buffers";
				# desc = "Search opened buffers";
			};
			"<Leader>ff" = {
				action = "find_files";
				# desc = "Search files in pwd";
			};
			"<Leader>fg" = {
				action = "live_grep";
				# desc = "Search string in pwd";
			};
			"<Leader>;/" = {
				action = "search_history";
				# desc = "Search history";
			};
			"<Leader>;;" = {
				action = "commands";
				# desc = "Command history";
			};
			"<Leader>;h" = {
				action = "help_tags";
				# desc = "Find help tags";
			};
			"<Leader>//" = {
				action = "builtin";
				# desc = "Shows builtins in telescope";
			};
			"<Leader>/m" = {
				action = "man_pages";
				# desc = "Search man pages";
			};
		};
	};
}
