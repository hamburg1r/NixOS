{config, ...}: {
  config.dendritic.home.disabled = [
    (
      {pkgs, ...}: {
        programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
          live-server
        ];
        programs.nixvim.extraPackages = [pkgs.nodePackages_latest.live-server];
      }
    )
  ];
}
