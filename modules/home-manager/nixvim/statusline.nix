{config, ...}: {
  config.dendritic.home.disabled = [
    (
      {pkgs, ...}: {
        #    
        programs.nixvim = {
          extraPlugins = with pkgs.vimPlugins; [
            lualine-nvim
          ];
          plugins.navic.enable = true;
          extraConfigLua = builtins.readFile ./lualine.lua;
        };
      }
    )
  ];
}
