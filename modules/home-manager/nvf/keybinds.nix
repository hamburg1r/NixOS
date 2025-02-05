{
	...
}: {
	vim.keymaps = let
		cmd = s: "<CMD>${s}<CR>";
		ldr = m: "<localleader>${m}";
		t = m: ldr "t${m}";
	in [
		{
			key = t "h";
			mode = "n";
			silent = true;
			desc = "Toggle search highlight";
			action = cmd "nohlsearch";
		}
		# {}
	];
}
