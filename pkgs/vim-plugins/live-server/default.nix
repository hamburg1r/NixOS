{
	vimUtils,
	fetchFromGitHub
}:
vimUtils.buildVimPlugin rec {
	pname = "live-server.nvim";
	version = "master";
	dontBuild = true;
	src = fetchFromGitHub{
		owner = "barrett-ruth";
		repo = pname;
		rev = "a2becf0d0aca59da85c3870e8eab6bf61f61e8d9";
		hash = "sha256-HnkGb6CcsIgj9xQoK5egFWCtIsgPE0qqr3v4cW0b6t4=";
	};
}
