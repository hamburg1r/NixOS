{
	...
}: {
	vim.debugger = {
		nvim-dap = {
			enable = true;
			ui.enable = true;
		};
	};
	vim.languages = {
		dart.dap.enable = true;
	};
}
