return {
	-- disable trouble
	-- { "folke/trouble.nvim", enabled = false },
	-- disable trouble
	-- { "folke/snacks.nvim", enabled = false },
	{ "johnelliott/vim-kinesis-kb900" },
	{ "akinsho/bufferline.nvim", enabled = false },
	{ "nvim-lualine/lualine.nvim", enabled = false },
	{ "folke/noice.nvim", enabled = false },
	{ "fatih/vim-go" },
	{ "folke/flash.nvim", enabled = false },

	-- I thought I was going to need to disable this for hidden text, but learned that conceallevle is a thing now
	-- { "iamcco/markdown-preview.nvim", enabled = false },
	-- { "markdown-preview.nvim", enabled = false },
	-- {
	-- 	"MeanderingProgrammer/render-markdown.nvim",
	-- 	enabled = false,
	-- 	opts = {
	-- 		code = {
	-- 			sign = false,
	-- 			width = "block",
	-- 			right_pad = 1,
	-- 		},
	-- 		heading = {
	-- 			sign = false,
	-- 			icons = {},
	-- 		},
	-- 		checkbox = {
	-- 			enabled = false,
	-- 		},
	-- 	},
	-- },
	-- Disable inlay_hints
	{
		"nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = false },
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
			lualine = { enabled = false },
			keys = {
				{ "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
				{ "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
			},
		},
	},
}
