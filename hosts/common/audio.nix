{
	pkgs,
	...
}: {
	# TODO: try noisetorch
	environment.systemPackages = with pkgs; [
		helvum
		pavucontrol
		stable.easyeffects
	];

	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		audio.enable = true;
		pulse.enable = true;
		jack.enable = true;
		extraConfig = let
			quantum = "1024";
			rate = "48000";
		in {
			pipewire."92-low-latency" = {
				"context.properties" = {
					"default.clock.rate" = rate;
					"default.clock.quantum" = quantum;
					"default.clock.min-quantum" = quantum;
					"default.clock.max-quantum" = quantum;
				};
			};
			pipewire-pulse."92-low-latency" = {
				"context.properties" = [
					{
						name = "libpipewire-module-protocol-pulse";
						args = { };
					}
				];
				"pulse.properties" = {
					"pulse.min.req" = "${quantum}/${rate}";
					"pulse.default.req" = "${quantum}/${rate}";
					"pulse.max.req" = "${quantum}/${rate}";
					"pulse.min.quantum" = "${quantum}/${rate}";
					"pulse.max.quantum" = "${quantum}/${rate}";
				};
				"stream.properties" = {
					"node.latency" = "${quantum}/${rate}";
					"resample.quality" = 1;
				};
			};
		};
		wireplumber = {
			# TODO: check out NixOS wiki for updates on this
			configPackages = [
				(pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
					bluez_monitor.properties = {
						["bluez5.enable-sbc-xq"] = true,
						["bluez5.enable-msbc"] = true,
						["bluez5.enable-hw-volume"] = true,
						["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
					}
				'')
			];
		};
	};
}
