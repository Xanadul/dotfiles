return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			local builtin = require("telescope.builtin")
			local wk = require("which-key")
			wk.register({
				c = {
          -- NOTE: name = ... is in none-ls.lua
					r = { builtin.lsp_references , "References" },
          c = { name = "+calls",
            i = { builtin.lsp_incoming_calls , "Incoming" },
            o = { builtin.lsp_outgoing_calls , "Outgoing" },
          },
					s = { builtin.lsp_document_symbols , "Symbols" },
					i = { builtin.lsp_implementations , "Implementations" },
					d = { builtin.lsp_definitions , "Definitions" },
				},
        f = {
          name = "Find",
          f = { builtin.find_files, "Files" },
          g = { builtin.live_grep, "Grep" },
          b = { builtin.buffers, "Buffers" },
          h = { builtin.help_tags, "Help Tags"}
        },
        b = {
          name = "Buffer",
          b = {builtin.buffers, "Find"},
          i = {builtin.buffers, "Find (Deprecated)"},
        }
			}, { prefix = "<leader>" })
			require("telescope").load_extension("ui-select")
		end,
	},
}
