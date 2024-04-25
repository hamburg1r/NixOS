{ ... }: {
	programs.nixvim.plugins = {
		noice = {
			enable = true;
			presets = {
				# bottom_search = true;
				# command_palette = true;
				long_message_to_split = true;
				lsp_doc_border = true;
			};
			# cmdline = {
			# 	view = "cmdline";
			# };
		};
	};
}
