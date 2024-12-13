{
	inputs,
	vimUtils
}:
vimUtils.buildVimPlugin {
	pname = "journal.nvim";
	version = "master";
	dontBuild = true;
	src = inputs.journal-nvim;
}
