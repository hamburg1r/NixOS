{
	outputs,
	lib,
	pkgs,
	config,
	...
}: {
	imports = [
		../common
		./environment.nix
		./gui
		./shell
		./specialisation.nix
		./theme.nix
		./miscellaneous.nix
	];
	home = {
		activation.zshCompCacheRegen = lib.mkIf config.programs.zsh.enable (lib.hm.dag.entryAfter ["writeBoundary"] ''
			run ${pkgs.zsh}/bin/zsh -c "autoload -U compinit && compinit"
		'');
		username = "hamburgir";
		enableNixpkgsReleaseCheck = true;

		sessionPath = [ "$HOME/.local/bin" ];
	};
	nixpkgs = {
		overlays = [
			outputs.overlays.additions
			outputs.overlays.modifications
			outputs.overlays.stable-packages
			outputs.overlays.unstable-packages
                                                                                
			# You can also add overlays exported from other flakes:
			# neovim-nightly-overlay.overlays.default
                                                                                
			# Or define it inline, for example:
			# (final: prev: {
			#   hi = final.hello.overrideAttrs (oldAttrs: {
			#     patches = [ ./change-hello-to-hi.patch ];
			#   });
			# })
		];
		config = {
			allowUnfree = true;
			allowUnfreePredicate = (_: true);
		};
	};
                                                                                
	# manual = {
	# 	manpages.enable = true;
	# 	html.enable = true;
	# 	json.enable = true;
	# };
}
