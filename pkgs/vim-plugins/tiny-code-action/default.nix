{
	inputs,
	vimUtils
}:
vimUtils.buildVimPlugin {
	pname = "tiny-code-action.nvim";
	version = "master";
	dontBuild = true;
	src = inputs.tiny-code-action;
}
