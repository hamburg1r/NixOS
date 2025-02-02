{
	...
}: {
	vim.telescope = {
		enable = true;
		mappings = let
			ldr = key: "<leader>${key}";
		in {
			open = ldr "//";
			resume = null;

			treesitter = ldr "/ts";

			diagnostics = ldr "cdt";
			lspDefinitions = ldr "cD";
			lspDocumentSymbols = ldr "cs";
			lspImplementations = ldr "ci";
			lspReferences = ldr "cr";
			lspTypeDefinitions = ldr "ct";
			lspWorkspaceSymbols = ldr "cS";

			gitBranches = ldr "gb";
			gitBufferCommits = ldr "gcb";
			gitCommits = ldr "gcg";
			gitStash = ldr "gS";
			gitStatus = ldr "gs";

			helpTags = ldr ";h";

			buffers = ldr "fb";
			findFiles = ldr "ff";
			liveGrep = ldr "fg";
			findProjects = ldr "fp";
		};
		setupOpts.defaults = {
			# layout_strategy = "flex";
			path_display = [
				"absolute"
				"smart"
				"shorten"
			];
		};
	};
}
