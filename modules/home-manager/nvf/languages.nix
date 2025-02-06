{
	pkgs,
	...
}: {
	vim.languages = {
		enableFormat = false;
		enableExtraDiagnostics = true;
		dart = {
			enable = true;
			flutter-tools = {
				enable = true;
				enableNoResolvePatch = false; # if dart missing from path
				color = {
					enable = true;
					highlightBackground = true;
					# virtualText.enable = true;
				};
			};
		};
		nix = {
			enable = true;
		};
		typst = {
			enable = true;
			extensions.typst-preview-nvim.setupOpts.open_cmd = "${pkgs.zathura}/bin/zathura";
		};
	};
}
