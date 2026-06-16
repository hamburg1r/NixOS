{
	config,
	lib,
	pkgs,
	...
}: {
	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		acpi
		# TODO: add keybinds in shell for controlling brightness
		brightnessctl
		git
		lf
		neovim
		trash-cli
		wget
	];
	programs.zsh = {
		enable = lib.mkDefault true;
		enableBashCompletion = true;
		enableCompletion = true;
		autosuggestions = {
			enable = lib.mkDefault true;
			async = true;
			strategy = [
				"history"
				"completion"
			];
		};
		setOptions = lib.mkDefault [
			"AUTO_CD"
			"AUTO_LIST"
			"AUTO_MENU"
			"AUTO_PARAM_KEYS"
			"AUTO_PARAM_SLASH"
			"AUTO_REMOVE_SLASH"
			"AUTO_PUSHD"
			# TODO: complete setup of zsh
			# From BASH_AUTO_LIST     zshoptions(1) Line 153
			"CD_SILENT"
			"EXTENDED_HISTORY"
			"HIST_IGNORE_SPACE"
			"HIST_FCNTL_LOCK"
			"HIST_FIND_NO_DUPS"
			"HIST_IGNORE_ALL_DUPS"
			"HIST_IGNORE_DUPS"
			"HIST_SAVE_NO_DUPS"
			"PUSHD_IGNORE_DUPS"
			"RM_STAR_WAIT"
			"SHARE_HISTORY"
		];
		interactiveShellInit = ''
            zmodload zsh/terminfo

            # Bind terminfo keys if available
            [[ -n "$terminfo[khome]" ]] && bindkey "$terminfo[khome]" beginning-of-line
            [[ -n "$terminfo[kend]"  ]] && bindkey "$terminfo[kend]"  end-of-line
            [[ -n "$terminfo[kdch1]" ]] && bindkey "$terminfo[kdch1]" delete-char

            # Fallback: also bind the alternate sequences explicitly
            bindkey "^[[1~" beginning-of-line
            bindkey "^[[4~" end-of-line
            bindkey "^[[H"  beginning-of-line
            bindkey "^[[F"  end-of-line
            bindkey "^[[3~" delete-char

            bindkey "^P" up-line-or-history
            bindkey "^N" down-line-or-history
        '';
	};
	environment.pathsToLink = lib.mkIf config.programs.zsh.enable [ "/share/zsh" ];
}
