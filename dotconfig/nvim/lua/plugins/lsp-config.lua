return {
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v4.x',
		lazy = true,
		config = false,
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			'L3MON4D3/LuaSnip',
			dependencies = {
				"saadparwaiz1/cmp_luasnip"
			},
			config = function()
				local ls = require('luasnip')
				ls.config.set_config {
					history = false,
					updateevents = 'TextChanged,TextChangedI'
				}

				-- Custom snippets per language
				for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
					loadfile(ft_path)()
				end

				-- Ctrl-up / Ctrl-down for jumping to snippet nodes
				vim.keymap.set({ "i", "s" }, "<c-Down>", function()
					if ls.expand_or_jumpable() then
						ls.expand_or_jump()
					end
				end, { silent = true })
				vim.keymap.set({ "i", "s" }, "<c-Up>", function()
					if ls.jumpable(-1) then
						ls.jump(-1)
					end
				end, { silent = true })
			end,
			build = (function()
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
					return
				end
				return 'make install_jsregexp'
			end)(),
		},
		config = function()
			local cmp = require('cmp')
			require("luasnip.loaders.from_vscode").lazy_load()
			local lspkind = require('lspkind')



			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = 'symbol_text',
						maxwidth = 50,
						ellipsis_char = '...',
						show_labelDetails = true,
					})
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				sources = {
					{
						name = 'lazydev',
						-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
						group_index = 0
					},
					{ name = 'luasnip' },
					{ name = 'nvim_lsp' },
					{ name = 'path' }
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
					['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
					['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
					['<C-y>'] = cmp.config.disable,
					['<C-e>'] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					["<CR>"] = cmp.mapping.confirm({
						select = true,
					}),
					["<C-i>"] = cmp.mapping.confirm({
						behaviour = cmp.ConfirmBehavior.Insert,
						select = true,
					}),
					['<C-u>'] = cmp.mapping.scroll_docs(-4),
					['<C-d>'] = cmp.mapping.scroll_docs(4),
				}),
			})
		end
	},

	-- LSP
	{
		'neovim/nvim-lspconfig',
		cmd = 'LspInfo',
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			{ 'hrsh7th/cmp-nvim-lsp',
				'hrsh7th/cmp-path'
			},
		},
		config = function()
			local lsp_zero = require('lsp-zero')

			-- lsp_attach is where you enable features that only work
			-- if there is a language server active in the file
			local lsp_attach = function(client, bufnr)
				local opts = { buffer = bufnr }

				vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
				vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
				vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
				vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
				vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
				vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
				vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
				vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
				vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
				vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
			end

			lsp_zero.extend_lspconfig({
				sign_text = true,
				lsp_attach = lsp_attach,
				capabilities = require('cmp_nvim_lsp').default_capabilities()
			})

			-- These are just examples. Replace them with the language
			-- servers you have installed in your system
			require('lspconfig').ruff.setup({})
			require('lspconfig').jdtls.setup({})
			require('lspconfig').pyright.setup({})
			require('lspconfig').nil_ls.setup({})
			require('lspconfig').lua_ls.setup({})
			require('lspconfig').zls.setup({})
			require('lspconfig').texlab.setup({})
			require('lspconfig').clangd.setup({})
			require('lspconfig').bashls.setup({})
			require('lspconfig').hyprls.setup({})

			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
				callback = function(event)
					-- NOTE: Remember that Lua is a real programming language, and as such it is possible
					-- to define small helper and utility functions so you don't have to repeat yourself.
					--
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc)
						vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

					-- Find references for the word under your cursor.
					map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

					map('<leader>cf', vim.lsp.buf.format, '[C]ode [F]ormat')

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
						vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd('LspDetach', {
							group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
							end,
						})
					end
				end
			})
		end


	},


	-- Small GUI in lower right for LSP notifications
	{ 'j-hui/fidget.nvim',   opts = {} },

	{ 'onsails/lspkind.nvim' },


	{
		"folke/trouble.nvim",
		config = function()
			vim.keymap.set("n", "<leader>tt", "<CMD>TroubleToggle<CR>", {})
		end
	},

	{
		"ledger/vim-ledger"
	},
	{
		"akinsho/flutter-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		config = function()
			require("flutter-tools").setup {
				widget_guides = {
					enabled = false,
				},
				closing_tags = {
					--highlight = "ErrorMsg", -- highlight for the closing tag
					prefix = ">", -- character to use for close tag e.g. > Widget
					enabled = true -- set to false to disable
				},
				outline = {
					open_cmd = "30vnew", -- command to use to open the outline buffer
					auto_open = false -- if true this will open the outline automatically when it is first populated
				},
				lsp = {
					color = { -- show the derived colours for dart variables
						enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
						background = false, -- highlight the background
						background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
						foreground = false, -- highlight the foreground
						virtual_text = true, -- show the highlight using virtual text
						virtual_text_str = "■", -- the virtual text character to highlight
					},
					-- see the link below for details on each option:
					-- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
					settings = {
						showTodos = false,
						completeFunctionCalls = true,
						renameFilesWithClasses = "prompt", -- "always"
						enableSnippets = true,
						lineLength = 160,
						updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
					}
				}
			}
		end,
	},
		{ "folke/neodev.nvim", opts = {} }, -- Helps luals with the vim API
}
