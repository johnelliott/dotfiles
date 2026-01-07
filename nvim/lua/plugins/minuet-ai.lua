---@type LazySpec
return {
	{
		"milanglacier/minuet-ai.nvim",
		config = function()
			require("minuet").setup({
				provider = "openai_fim_compatible",
				n_completions = 1, -- recommend for local model for resource saving
				-- I recommend beginning with a small context window size and incrementally
				-- expanding it, depending on your local computing power. A context window
				-- of 512, serves as an good starting point to estimate your computing
				-- power. Once you have a reliable estimate of your local computing power,
				-- you should adjust the context window to a larger value.
				context_window = 1024,
				provider_options = {
					openai_fim_compatible = {
						-- https://github.com/milanglacier/minuet-ai.nvim?tab=readme-ov-file#ollama-qwen-25-coder7b
						api_key = "TERM", -- ollama uses "TERM" as a special value
						name = "Local_Models",
						end_point = "http://0.0.0.0:11434/v1/completions",
						model = "qwen2.5-coder:1.5b",
						optional = {
							max_tokens = 56,
							top_p = 0.9,
						},
						-- Llama.cpp does not support the `suffix` option in FIM completion.
						-- Therefore, we must disable it and manually populate the special
						-- tokens required for FIM completion.
						template = {
							prompt = function(context_before_cursor, context_after_cursor, _)
								return "<|fim_prefix|>"
									.. context_before_cursor
									.. "<|fim_suffix|>"
									.. context_after_cursor
									.. "<|fim_middle|>"
							end,
							suffix = false,
						},
					},
				},
				-- Additional configs go here in presets
				presets = {
					Empty = {},
					Claude = {
						max_tokens = 256,
						-- To get the exact model, do:
						-- curl https://api.anthropic.com/v1/models \
						--	  header "x-api-key: $ANTHROPIC_API_KEY" \
						--	  header "anthropic-version: 2023-06-01"|jq
						-- so you know the exact string or you'll get a 404
						model = "claude-haiku-4-5-20251001",
						stream = true,
						api_key = "ANTHROPIC_API_KEY",
						end_point = "https://api.anthropic.com/v1/messages",
						optional = {},
					},
					Local_Models = {
						api_key = "TERM",
						name = "Local_Models",
						end_point = "http://0.0.0.0:11434/v1/completions",
						model = "qwen2.5-coder:1.5b",
						optional = {
							max_tokens = 56,
							top_p = 0.9,
						},
						-- Llama.cpp does not support the `suffix` option in FIM completion.
						-- Therefore, we must disable it and manually populate the special
						-- tokens required for FIM completion.
						template = {
							prompt = function(context_before_cursor, context_after_cursor, _)
								return "<|fim_prefix|>"
									.. context_before_cursor
									.. "<|fim_suffix|>"
									.. context_after_cursor
									.. "<|fim_middle|>"
							end,
							suffix = false,
						},
					},
				},
			})
			-- disable minuet by default
			vim.cmd("silent Minuet blink disable")
			vim.cmd("silent Minuet cmp disable")
			--vim.cmd("Minuet change_preset blank")

			-- AI completion toggle functions
			vim.keymap.set("n", "<leader>ae", function()
				vim.cmd("Minuet blink enable")
				-- vim.cmd("Copilot disable")
				--vim.cmd("Minuet change_preset blank")
				print("Minuet enabled")
			end, { desc = "[A]E: [A]I [E]nable" })

			vim.keymap.set("n", "<leader>ad", function()
				-- Disable both
				vim.cmd("Minuet blink disable")
				print("AI completion disabled")
			end, { desc = "[A]D: [A]I [D]isable" })
		end,
	},
}
