{
	config,
	lib,
	pkgs,
	...
}: {
	options = with lib; {
		desktop = {
			modifier = mkOption {
				default = "super";
				type = types.str;
				description = "Modifier used to set wm keybinds";
			};
			keybinds = {
				terminal = mkOption {
					default = [ [] ["return"] ];
					type = types.listOf types.raw;
					description = "key used to open terminal, format: [ [\"modifier1\", ...], [\"key\"] ]";
				};
				movement = {
					left = mkOption {
						default = [ "left" "h" ];
						type = types.listOf types.str;
						description = "key used for moving left";
					};
					right = mkOption {
						default = [ "right" "l" ];
						type = types.listOf types.str;
						description = "key used for moving right";
					};
					up = mkOption {
						default = [ "up" "k" ];
						type = types.listOf types.str;
						description = "key used for moving up";
					};
					down = mkOption {
						default = [ "down" "j" ];
						type = types.listOf types.str;
						description = "key used for moving down";
					};
					first = mkOption {
						default = [ "home" "a" ];
						type = types.listOf types.str;
						description = "key used for moving to the first column/window";
					};
					last = mkOption {
						default = [ "end" "apostrophe" ];
						type = types.listOf types.str;
						description = "key used for moving to the last column/window";
					};
				};
				app-launcher = mkOption {
					default = [ [] ["r"] ];
					type = types.listOf types.raw;
					description = "key used to open app launcher, format: [ [\"modifier1\", ...], [\"key\"] ]";
				};
				show-help = mkOption {
					default = [ ["Shift"] ["Slash"] ];
					type = types.listOf types.raw;
					description = "key used to show help overlay, format: [ [\"modifier1\", ...], [\"key\"] ]";
				};
				screenshot = mkOption {
					default = [ ["Shift"] ["s"] ];
					type = types.listOf types.raw;
					description = "key used to take screenshot, format: [ [\"modifier1\", ...], [\"key\"] ]";
				};
				                close-window = mkOption {
				                    default = [ ["Shift"] ["x"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to close window, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				                fullscreen = mkOption {
				                    default = [ [] ["f"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to fullscreen window, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				                maximize = mkOption {
				                    default = [ ["Shift"] ["f"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to maximize window to edges, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				                toggle-windowed-fullscreen = mkOption {
				                    default = [ ["Control"] ["f"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to toggle windowed fullscreen, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				                quit = mkOption {
				                    default = [ ["Shift"] ["q"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to quit session, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				                toggle-tabbed-window = mkOption {
				                    default = [ [] ["t"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to toggle column tabbed display, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				                column-size-preset-next = mkOption {
				                    default = [ [] ["bracketright"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to cycle to next column size preset, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				                column-size-preset-back = mkOption {
				                    default = [ [] ["bracketleft"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to cycle to previous column size preset, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				                window-width-preset-next = mkOption {
				                    default = [ ["Shift"] ["bracketright"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to cycle to next window width preset, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				                window-width-preset-back = mkOption {
				                    default = [ ["Shift"] ["bracketleft"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to cycle to previous window width preset, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				                window-height-preset-next = mkOption {
				                    default = [ ["Shift"] ["period"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to cycle to next window height preset, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				                window-height-preset-back = mkOption {
				                    default = [ ["Shift"] ["comma"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to cycle to previous window height preset, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				                toggle-floating = mkOption {
				                    default = [ ["Shift"] ["space"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to toggle window floating, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				                move-column-to-first = mkOption {
				                    default = [ ["Control"] ["Home"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to move column to first position, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				                move-column-to-last = mkOption {
				                    default = [ ["Control"] ["End"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to move column to last position, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				                toggle-focus-floating = mkOption {
				                    default = [ [] ["space"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to switch focus between floating and tiling windows, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				                toggle-workspace-overview = mkOption {
				                    default = [ [] ["o"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to toggle the workspace overview, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				                fake-maximize = mkOption {
				                    default = [ ["Alt"] ["f"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to maximize the current column, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				                center-visible-columns = mkOption {
				                    default = [ ["Shift"] ["c"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to center visible columns, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				                center-column = mkOption {
				                    default = [ [] ["c"] ];
				                    type = types.listOf types.raw;
				                    description = "key used to center the current column, format: [ [\"modifier1\", ...], [\"key\"] ]";
				                };
				no-mod = {
					speaker-volume-up = mkOption {
						default = [ [] ["XF86AudioRaiseVolume"] ];
						type = types.listOf types.raw;
						description = "key used to increase speaker volume, format: [ [\"modifier1\", ...], [\"key\"] ]";
					};
					speaker-volume-down = mkOption {
						default = [ [] ["XF86AudioLowerVolume"] ];
						type = types.listOf types.raw;
						description = "key used to decrease speaker volume, format: [ [\"modifier1\", ...], [\"key\"] ]";
					};
					speaker-mute = mkOption {
						default = [ [] ["XF86AudioMute"] ];
						type = types.listOf types.raw;
						description = "key used to toggle speaker mute, format: [ [\"modifier1\", ...], [\"key\"] ]";
					};
					mic-volume-up = mkOption {
						default = [ ["Control"] ["XF86AudioRaiseVolume"] ];
						type = types.listOf types.raw;
						description = "key used to increase microphone volume, format: [ [\"modifier1\", ...], [\"key\"] ]";
					};
					mic-volume-down = mkOption {
						default = [ ["Control"] ["XF86AudioLowerVolume"] ];
						type = types.listOf types.raw;
						description = "key used to decrease microphone volume, format: [ [\"modifier1\", ...], [\"key\"] ]";
					};
					mic-mute = mkOption {
						default = [ ["Control"] ["XF86AudioMute"] ];
						type = types.listOf types.raw;
						description = "key used to toggle microphone mute, format: [ [\"modifier1\", ...], [\"key\"] ]";
					};
					mpiris-play-pause = mkOption {
						default = [ [] ["XF86AudioPlay"] ];
						type = types.listOf types.raw;
						description = "key used to toggle play/pause for MPRIS players";
					};
					mpiris-stop = mkOption {
						default = [ [] ["XF86AudioStop"] ];
						type = types.listOf types.raw;
						description = "key used to stop MPRIS players";
					};
					mpiris-next = mkOption {
						default = [ [] ["XF86AudioNext"] ];
						type = types.listOf types.raw;
						description = "key used to go to next track for MPRIS players";
					};
					mpiris-previous = mkOption {
						default = [ [] ["XF86AudioPrev"] ];
						type = types.listOf types.raw;
						description = "key used to go to previous track for MPRIS players";
					};
					brightness-up = mkOption {
						default = [ [] ["XF86MonBrightnessUp"] ];
						type = types.listOf types.raw;
						description = "key used to increase screen brightness";
					};
					brightness-down = mkOption {
						default = [ [] ["XF86MonBrightnessDown"] ];
						type = types.listOf types.raw;
						description = "key used to decrease screen brightness";
					};
				};
			};
		};
	};
}
