{
	inputs,
	pkgs,
	vimUtils
}:
vimUtils.buildVimPlugin {
	pname = "tiny-code-action.nvim";
	version = "master";
	dontBuild = true;
	src = inputs.tiny-code-action;
	dependencies = [
		pkgs.vimPlugins.plenary-nvim
		pkgs.vimPlugins.telescope-nvim
	];
	postPatch = ''
		substituteInPlace lua/tiny-code-action/backend/delta.lua \
			--replace 'command = "delta"' 'command = "${pkgs.delta}/bin/delta"'
	'';

}
