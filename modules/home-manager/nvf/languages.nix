{
	pkgs,
	...
}: {
	vim.languages = {
		typst = {
			enable = true;
			extensions.typst-preview-nvim.setupOpts.open_cmd = "${pkgs.zathura}/bin/zathura";
		};
	};
}
