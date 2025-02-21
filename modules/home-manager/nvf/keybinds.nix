{
	...
}: {
	vim = {
		keymaps = let
			cmd = s: "<CMD>${s}<CR>";

			ldr = m: "<leader>${m}";
			lldr = m: "<localleader>${m}";

			c = m: ldr "c${m}";
			tl = m: lldr "t${m}";
		in [
			{
				key = tl "h";
				mode = "n";
				silent = true;
				desc = "Toggle search highlight";
				action = cmd "nohlsearch";
			}
			{
				key = tl "w";
				mode = "n";
				silent = true;
				desc = "Toggle wrap";
				action = cmd "set wrap!";
			}
			{
				key = c "a";
				mode = "n";
				silent = true;
				desc = "Code Action";
				action = "function() require('tiny-code-action').code_action() end";
				lua = true;
			}
		];
	};
}
