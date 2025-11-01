return {
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		config = function(_, opts)
			require("cyberdream").setup(opts)
			-- fix fillchars
			vim.opt.fillchars:append({ eob = "~" })
		end,
		extensions = {
			lualine = false,
		},
		opts = {
			variant = "auto",
			-- Enable transparent background
			transparent = true,
			-- Enable italics comments
			italic_comments = false,
			-- Apply a modern borderless look to pickers like Telescope, Snacks Picker & Fzf-Lua
			borderless_pickers = false,
			extensions = {
				lualine = false,
			},
		},
	},
	{
		"f-person/auto-dark-mode.nvim",
		opts = {
			priority = 1000,
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			set_dark_mode = function()
				-- vim.api.nvim_set_option_value("background", "dark", {})
				vim.o.background = "dark"
				-- vim.cmd("colorscheme dracula")
			end,
			set_light_mode = function()
				-- vim.api.nvim_set_option_value("background", "light", {})
				vim.o.background = "light"
				-- vim.cmd("colorscheme lunaperche")
			end,
			update_interval = 3000,
			fallback = "light",
		},
	},
	-- Configure LazyVim to load gruvbox
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "cyberdream",
		},
	},
}
