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
		./gui.nix
		./language.nix
		./login.nix
		./network.nix
		./packages
		./time.nix
		./users.nix
		./vm.nix

		outputs.nixosModules.automount


		./syncthing.nix
	];

	programs.nix-ld = {
		enable = true;
		libraries = with pkgs; [];
	};
}
