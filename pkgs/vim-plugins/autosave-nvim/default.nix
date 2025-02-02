{
	inputs,
	vimUtils
}:
vimUtils.buildVimPlugin {
	pname = "autosave.nvim";
	version = "master";
	dontBuild = true;
	src = inputs.autosave-nvim;
}
