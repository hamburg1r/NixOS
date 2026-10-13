{
  inputs,
  vimUtils,
}:
vimUtils.buildVimPlugin {
  pname = "live-server.nvim";
  version = "master";
  dontBuild = true;
  src = inputs.live-server;
}
