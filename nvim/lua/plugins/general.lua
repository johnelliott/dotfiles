return {
	-- disable trouble
	-- { "folke/trouble.nvim", enabled = false },
	-- disable trouble
	-- { "folke/snacks.nvim", enabled = false },
	-- { "johnelliott/vim-kinesis-kb900" },
	{ "akinsho/bufferline.nvim", enabled = false },
	{ "nvim-lualine/lualine.nvim", enabled = true },
	{ "folke/noice.nvim", enabled = false },
	{ "fatih/vim-go" },
	{ "folke/flash.nvim", enabled = false },
	{
		"nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = true },
		},
	},
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			animate = { enabled = false },
			dashboard = { enabled = false },
			input = { enabled = false },
			notifier = { enabled = false },
			scope = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = false }, -- we set this in options.lua
			toggle = { map = LazyVim.safe_keymap_set },
			words = { enabled = false },
			-- turn off scrolling crap
			indent = {
				enabled = false, -- Disable at start, can re-enable with their hotkeys
				animate = { enabled = false },
			},
			bufferline = { enabled = false },
			lualine = { enabled = true },
			keys = {
				{ "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
				{ "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
			},
		},
	},
}
