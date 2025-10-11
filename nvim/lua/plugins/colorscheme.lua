return {
	--{ "dracula/vim", priority = 1000, lazy = false },
	{ "dracula/vim" },
	{
		"navarasu/onedark.nvim",
		priority = 999, -- make sure to load this before all the other start plugins
		config = function()
			-- Lua
			require("onedark").setup({
				-- Main options --
				-- style = "light", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
				transparent = false, -- Show/hide background
				term_colors = true, -- Change terminal color as per the selected theme style
				ending_tildes = true, -- Show the end-of-buffer tildes. By default they are hidden
				cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

				-- toggle theme style ---
				toggle_style_key = "<leader>ts", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
				-- toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between
				toggle_style_list = { "dark", "light" }, -- List of styles to toggle between

				-- Change code style ---
				-- Options are italic, bold, underline, none
				-- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
				code_style = {
					comments = "italic",
					keywords = "none",
					functions = "none",
					strings = "none",
					variables = "none",
				},

				-- Lualine options --
				lualine = {
					transparent = false, -- lualine center bar transparency
				},

				-- Custom Highlights --
				colors = {}, -- Override default colors
				highlights = {}, -- Override highlight groups

				-- Plugins Config --
				diagnostics = {
					darker = true, -- darker colors for diagnostic
					undercurl = true, -- use undercurl instead of underline for diagnostics
					background = true, -- use background color for virtual text
				},
			})
			-- Enable theme
			-- require("onedark").load()
		end,
	},
	-- add gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		opts = {
			terminal_colors = true, -- add neovim terminal colors
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "hard", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = false,
		},
	},
	-- -- add catppuccin
	-- {
	-- 	"catppuccin/nvim",
	-- 	lazy = true,
	-- 	name = "catppuccin",
	-- 	opts = {
	-- 		integrations = {
	-- 			aerial = true,
	-- 			alpha = true,
	-- 			cmp = true,
	-- 			dashboard = true,
	-- 			flash = true,
	-- 			fzf = true,
	-- 			grug_far = true,
	-- 			gitsigns = true,
	-- 			headlines = true,
	-- 			illuminate = true,
	-- 			indent_blankline = { enabled = true },
	-- 			leap = true,
	-- 			lsp_trouble = true,
	-- 			mason = true,
	-- 			markdown = true,
	-- 			mini = true,
	-- 			native_lsp = {
	-- 				enabled = true,
	-- 				underlines = {
	-- 					errors = { "undercurl" },
	-- 					hints = { "undercurl" },
	-- 					warnings = { "undercurl" },
	-- 					information = { "undercurl" },
	-- 				},
	-- 			},
	-- 			navic = { enabled = true, custom_bg = "lualine" },
	-- 			neotest = true,
	-- 			neotree = true,
	-- 			noice = true,
	-- 			notify = true,
	-- 			semantic_tokens = true,
	-- 			snacks = true,
	-- 			telescope = true,
	-- 			treesitter = true,
	-- 			treesitter_context = true,
	-- 			which_key = true,
	-- 		},
	-- 	},
	-- 	specs = {
	-- 		{
	-- 			"akinsho/bufferline.nvim",
	-- 			optional = true,
	-- 			opts = function(_, opts)
	-- 				if (vim.g.colors_name or ""):find("catppuccin") then
	-- 					opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
	-- 				end
	-- 			end,
	-- 		},
	-- 	},
	-- },
	-- Configure LazyVim to load gruvbox
	{
		"LazyVim/LazyVim",
		opts = {
			-- colorscheme = "dracula",
			colorscheme = "onedark",
		},
	},
}
