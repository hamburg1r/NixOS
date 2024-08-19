{
	pkgs,
	...
}: {
	environment.packages = with pkgs; [
		neovim
		git
		(pkgs.writeShellScriptBin "update" ''
			OLDPWD = $(pwd)
			cd ~/.config/nix-on-droid
			if [[ ! -d "~/.config/nix-on-droid/.git" ]]; then
				echo "\"~/.config/nix-on-droid\" is not a git repo. Continuing"
			else
				git pull
			fi
			nix-on-droid switch --flake ~/.config/nix-on-droid
			cd $OLDPWD
		'')
	];

	environment.etcBackupExtension = ".bak";

	system.stateVersion = "24.05";

	nix.extraOptions = ''
		experimental-features = nix-command flakes
	'';

	time.timeZone = "Asia/Kolkata";
}
