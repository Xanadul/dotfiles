return {
	{
		"nvim-telescope/telescope.nvim",
		branch = '0.1.x',
		dependencies = {
			"nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				'nvim-telescope/telescope-fzf-native.nvim',

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = 'make',

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
			{ 'nvim-telescope/telescope-ui-select.nvim' },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
		},

		config = function()
			require("telescope").setup({
				extensions = {
          undo = {

          },
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require('telescope').load_extension, 'fzf')
			pcall(require('telescope').load_extension, 'ui-select')

			-- See `:help telescope.builtin`
			local builtin = require 'telescope.builtin'
			vim.keymap.set('n', "<leader>bb", builtin.buffers,{ desc = "[B]uffer" })
			vim.keymap.set('n', "<leader>cci", builtin.lsp_incoming_calls,{ desc = "[I]ncoming" })
			vim.keymap.set('n', "<leader>cco", builtin.lsp_outgoing_calls,{ desc = "[O]utgoing" })
			vim.keymap.set('n', "<leader>cd", builtin.lsp_definitions,{ desc = "[D]efinitions" })
			vim.keymap.set('n', "<leader>ci", builtin.lsp_implementations,{ desc = "[I]mplementations" })
			vim.keymap.set('n', "<leader>cr", builtin.lsp_references,{ desc = "[R]eferences" })
			vim.keymap.set('n', "<leader>cs", builtin.lsp_document_symbols,{ desc = "[S]ymbols" })
			vim.keymap.set('n', "<leader>fb", builtin.buffers,{ desc = "[B]uffers" })
			vim.keymap.set('n', "<leader>fc", builtin.commands,{ desc = "[C]ommand" })
			vim.keymap.set('n', "<leader>ff", builtin.find_files,{ desc = "[F]iles" })
			vim.keymap.set('n', "<leader>fg", builtin.live_grep,{ desc = "[G]rep" })
			vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'current [W]ord' })
			vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[K]eymaps' })
			vim.keymap.set('n', "<leader>fh", builtin.help_tags,{ desc = "[H]elp Tags"})
			vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[D]iagnostics' })
			vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[R]esume' })
			vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = 'Recent Files ("." for repeat)' })
			vim.keymap.set('n', '<leader>tu', "<cmd>Telescope undo<cr>", { desc = '[U]ndo-tree' })
			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set('n', '<leader>/', function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
					winblend = 10,
					previewer = true,
				})
			end, { desc = '[/] Fuzzily search in current buffer' })



require("telescope").load_extension("ui-select")

		end,
	},
}
