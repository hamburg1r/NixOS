{ pkgs, ... }: {
	programs.nixvim.plugins = {
		luasnip = {
			enable = true;
			# fromLua = path;
			# fromVscode = path;
		};
	};
	programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
		friendly-snippets
	];
	programs.nixvim.extraConfigLua = ''require("luasnip.loaders.from_vscode").lazy_load()'';
}
