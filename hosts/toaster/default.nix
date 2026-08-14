{
	outputs,
	pkgs,
	...
}: {
	imports = [
		../common
		./hardware

		./boot
		./bluetooth.nix
		./dev.nix
		./game.nix
		./gui.nix
		./language.nix
		./login.nix
		./network.nix
		./packages
		./time.nix
		./users.nix
		./vm.nix

		./syncthing.nix
	];

	programs.nix-ld = {
		enable = true;
	};
}
