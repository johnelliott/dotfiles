return {
	{ "akinsho/bufferline.nvim", enabled = false },
	{
		"nvim-lualine/lualine.nvim",
		enabled = false,
		opts = function()
			-- PERF: we don't need this lualine require madness 🤷
			local lualine_require = require("lualine_require")
			lualine_require.require = require

			local icons = LazyVim.config.icons

			vim.o.laststatus = vim.g.lualine_laststatus

			local opts = {
				options = {
					theme = "powerline", -- powerline_dark, powerline auto
					globalstatus = vim.o.laststatus == 3,
					disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
				},
				sections = {
					lualine_a = { "mode" },
					-- lualine_b = { "branch" },
					lualine_b = {},

					lualine_c = {
						LazyVim.lualine.root_dir(),
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ LazyVim.lualine.pretty_path() },
					},
					lualine_x = {
						Snacks.profiler.status(),
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = function() return { fg = Snacks.util.color("Statement") } end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { fg = Snacks.util.color("Constant") } end,
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return { fg = Snacks.util.color("Debug") } end,
            },
            -- stylua: ignore
            -- Don't show updates, there are always updates lol
            -- {
            --   require("lazy.status").updates,
            --   cond = require("lazy.status").has_updates,
            --   color = function() return { fg = Snacks.util.color("Special") } end,
            -- },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
					},
					lualine_y = {},
					lualine_z = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
						-- function()
						-- 	return " " .. os.date("%R")
						-- end,
					},
				},
				extensions = { "neo-tree", "lazy", "fzf" },
			}

			-- do not add trouble symbols if aerial is enabled
			-- And allow it to be overriden for some buffer types (see autocmds)
			if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
				local trouble = require("trouble")
				local symbols = trouble.statusline({
					mode = "symbols",
					groups = {},
					title = false,
					filter = { range = true },
					format = "{kind_icon}{symbol.name:Normal}",
					hl_group = "lualine_c_normal",
				})
				table.insert(opts.sections.lualine_c, {
					symbols and symbols.get,
					cond = function()
						return vim.b.trouble_lualine ~= false and symbols.has()
					end,
				})
			end

			return opts
		end,
	},
	{ "folke/noice.nvim", enabled = false },
	{ "fatih/vim-go" },
	{ "folke/flash.nvim", enabled = false },
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
			lualine = { enabled = true },
		},
	},
	{
		"saghen/blink.cmp",
		version = not vim.g.lazyvim_blink_main and "*",
		build = vim.g.lazyvim_blink_main and "cargo build --release",
		opts_extend = {
			"sources.completion.enabled_providers",
			"sources.compat",
			"sources.default",
		},
		dependencies = {
			"rafamadriz/friendly-snippets",
			-- add blink.compat to dependencies
			{
				"saghen/blink.compat",
				optional = true, -- make optional so it's only enabled if any extras need it
				opts = {},
				version = not vim.g.lazyvim_blink_main and "*",
			},
		},
		event = { "InsertEnter", "CmdlineEnter" },

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			snippets = {
				preset = "default",
			},

			appearance = {
				-- sets the fallback highlight groups to nvim-cmp's highlight groups
				-- useful for when your theme doesn't support blink.cmp
				-- will be removed in a future release, assuming themes add support
				use_nvim_cmp_as_default = false,
				-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			completion = {
				accept = {
					-- experimental auto-brackets support
					auto_brackets = {
						enabled = true,
					},
				},
				menu = {
					draw = {
						treesitter = { "lsp" },
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
				},
				ghost_text = {
					enabled = vim.g.ai_cmp,
				},
			},

			-- experimental signature help support
			-- signature = { enabled = true },

			sources = {
				-- adding any nvim-cmp sources here will enable them
				-- with blink.compat
				compat = {},
				default = { "lsp", "path", "snippets", "buffer" },
			},

			cmdline = {
				enabled = true,
				keymap = {
					preset = "cmdline",
					["<Right>"] = false,
					["<Left>"] = false,
				},
				completion = {
					list = { selection = { preselect = false } },
					menu = {
						auto_show = function(ctx)
							return vim.fn.getcmdtype() == ":"
						end,
					},
					ghost_text = { enabled = true },
				},
			},

			keymap = {
				preset = "default",
				-- ["<C-y>"] = { "select_and_accept" },
			},
		},
		---@param opts blink.cmp.Config | { sources: { compat: string[] } }
		config = function(_, opts)
			if opts.snippets and opts.snippets.preset == "default" then
				opts.snippets.expand = LazyVim.cmp.expand
			end
			-- setup compat sources
			local enabled = opts.sources.default
			for _, source in ipairs(opts.sources.compat or {}) do
				opts.sources.providers[source] = vim.tbl_deep_extend(
					"force",
					{ name = source, module = "blink.compat.source" },
					opts.sources.providers[source] or {}
				)
				if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
					table.insert(enabled, source)
				end
			end

			-- add ai_accept to <Tab> key
			if not opts.keymap["<Tab>"] then
				if opts.keymap.preset == "super-tab" then -- super-tab
					opts.keymap["<Tab>"] = {
						require("blink.cmp.keymap.presets").get("super-tab")["<Tab>"][1],
						LazyVim.cmp.map({ "snippet_forward", "ai_nes", "ai_accept" }),
						"fallback",
					}
				else -- other presets
					opts.keymap["<Tab>"] = {
						LazyVim.cmp.map({ "snippet_forward", "ai_nes", "ai_accept" }),
						"fallback",
					}
				end
			end

			-- Unset custom prop to pass blink.cmp validation
			opts.sources.compat = nil

			-- check if we need to override symbol kinds
			for _, provider in pairs(opts.sources.providers or {}) do
				---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
				if provider.kind then
					local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
					local kind_idx = #CompletionItemKind + 1

					CompletionItemKind[kind_idx] = provider.kind
					---@diagnostic disable-next-line: no-unknown
					CompletionItemKind[provider.kind] = kind_idx

					---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
					local transform_items = provider.transform_items
					---@param ctx blink.cmp.Context
					---@param items blink.cmp.CompletionItem[]
					provider.transform_items = function(ctx, items)
						items = transform_items and transform_items(ctx, items) or items
						for _, item in ipairs(items) do
							item.kind = kind_idx or item.kind
							item.kind_icon = LazyVim.config.icons.kinds[item.kind_name] or item.kind_icon or nil
						end
						return items
					end

					-- Unset custom prop to pass blink.cmp validation
					provider.kind = nil
				end
			end

			require("blink.cmp").setup(opts)
		end,
	},
}
