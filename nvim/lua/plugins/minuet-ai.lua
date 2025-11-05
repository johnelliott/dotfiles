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
				context_window = 512,

				provider_options = {
					-- openai_compatible = {
					-- 	model = "qwen2.5-coder:7b",
					-- 	system = "see [Prompt] section for the default value",
					-- 	few_shots = "see [Prompt] section for the default value",
					-- 	chat_input = "See [Prompt Section for default value]",
					-- 	stream = false,
					-- 	end_point = "https://0.0.0.0:8080/v1/chat/completions",
					-- 	api_key = "TERM",
					-- 	name = "Ramalama",
					-- 	optional = {
					-- 		stop = nil,
					-- 		max_tokens = 512,
					-- 	},
					-- },
					openai_fim_compatible = {
						-- For Windows users, TERM may not be present in environment variables.
						-- Consider using APPDATA instead.
						api_key = "TERM",
						name = "Ramalama-llama.cpp",
						-- stream = false,
						end_point = "http://0.0.0.0:8080/v1/completions",
						model = "PLACEHOLDER",
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
		end,
	},
	{ "nvim-lua/plenary.nvim" },
	-- optional, if you are using virtual-text frontend, nvim-cmp is not required.
	{ "hrsh7th/nvim-cmp" },
	-- optional, if you are using virtual-text frontend, blink is not required.
	{ "Saghen/blink.cmp" },
}
