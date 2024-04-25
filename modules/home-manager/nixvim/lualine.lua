--    
require("lualine").setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		section_separators = {
			left = "",
			right = ""
		}
	},
	sections = {
		lualine_a = {
			{
				"mode",
				-- fmt = function(str) return str:sub(1,1) end,
			},
		},
		lualine_b = {
			-- "branch",
			"diff",
			"diagnostics",
		},
		lualine_c = {
			"filename",
		},
		lualine_x = {
		},
		lualine_y = {
			"encoding",
			"fileformat",
			"filetype",
			-- "progress",
		},
		lualine_z = {
			-- "location",
			"branch",
		},
	},
	tabline = {
		lualine_a = {
			{
				"buffers",
				show_filename_only = false,
				hide_filename_extension = false,
				show_modified_status = true,

				mode = 2,
				max_length = vim.o.columns * 2/3,

				filetype_names = {
					TelescopePrompt = "Telescope",
				},

				use_mode_colors = true,

				symbols = {
					modified = ' ●',      -- Text to show when the buffer is modified
					alternate_file = '#', -- Text to show to identify the alternate file
					directory =  '',     -- Text to show when the buffer is a directory
				},
			},
			-- {
			-- 	"filename",
			-- },
		},
		lualine_z = {
			{
				"tabs",
				-- tab_max_length = 40,  -- Maximum width of each tab. The content will be shorten dynamically (example: apple/orange -> a/orange)
				-- max_length = vim.o.columns / 3, -- Maximum width of tabs component.
				-- 								-- Note:
				-- 								-- It can also be a function that returns
				-- 								-- the value of `max_length` dynamically.
				-- mode = 0, -- 0: Shows tab_nr
				-- 			-- 1: Shows tab_name
				-- 			-- 2: Shows tab_nr + tab_name
				--
				-- path = 0, -- 0: just shows the filename
				-- 			-- 1: shows the relative path and shorten $HOME to ~
				-- 			-- 2: shows the full path
				-- 			-- 3: shows the full path and shorten $HOME to ~
				--
				-- -- Automatically updates active tab color to match color of other components (will be overidden if buffers_color is set)
				-- use_mode_colors = false,
				--
				-- tabs_color = {
				-- 	-- Same values as the general color option can be used here.
				-- 	active = 'lualine_{section}_normal',     -- Color for active tab.
				-- 	inactive = 'lualine_{section}_inactive', -- Color for inactive tab.
				-- },
				--
				-- show_modified_status = true,  -- Shows a symbol next to the tab name if the file has been modified.
				-- symbols = {
				-- 	modified = '[+]',  -- Text to show when the file is modified.
				-- },
				--
				-- fmt = function(name, context)
				-- 	-- Show + if buffer is modified in tab
				-- 	local buflist = vim.fn.tabpagebuflist(context.tabnr)
				-- 	local winnr = vim.fn.tabpagewinnr(context.tabnr)
				-- 	local bufnr = buflist[winnr]
				-- 	local mod = vim.fn.getbufvar(bufnr, '&mod')
				--
				-- 	return name .. (mod == 1 and " +" or "")
				-- end
			}
		}
	},
	winbar = {
		lualine_a = {
			{
				"diagnostics",
				update_in_insert = true,
			},
			{
				function()
					return require("nvim-navic").get_location()
				end,
				cond = function()
					return require("nvim-navic").is_available()
				end,
				-- color_correction = "static",
			},
		},
		lualine_y = {
			"progress",
		},
		lualine_z = {
			"location",
		},
	},
	inactive_winbar = {
		lualine_a = {
			"filename"
		},
		lualine_z = {
			"progress",
			"location"
		},
	},
})
require("luasnip").config.set_config({})
