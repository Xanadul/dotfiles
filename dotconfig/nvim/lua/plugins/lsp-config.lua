return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{
				"onsails/lspkind.nvim",
			},
			{
				"williamboman/mason.nvim",
				lazy = false,
				opts = {
					auto_install = true,
				},
				config = true
			},
			'williamboman/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',
			{ 'j-hui/fidget.nvim', opts = {} },

			-- Allows extra capabilities provided by nvim-cmp
			'hrsh7th/cmp-nvim-lsp',
		},
		config = function()
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

					-- -- The following code creates a keymap to toggle inlay hints in your
					-- -- code, if the language server you are using supports them
					-- --
					-- -- This may be unwanted, since they displace some of your code
					-- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					-- 	map('<leader>th', function()
					-- 		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
					-- 	end, '[T]oggle Inlay [H]ints')
					-- end
				end,
			})
			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				-- clangd = {},
				-- gopls = {},
				-- pyright = {},
				-- rust_analyzer = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`tsserver`) will work just fine
				-- tsserver = {},
				--
				ruff_lsp = {
					capabilities = capabilities,
				},
				lua_ls = {
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = 'Replace',
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			require('mason').setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				'stylua', -- Used to format Lua code
				'zls',
				'ruff',
				'ruff-lsp',
				'eslint',
				'tsserver'
			})
			require('mason-tool-installer').setup { ensure_installed = ensure_installed }

			require('mason-lspconfig').setup {
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
						require('lspconfig')[server_name].setup(server)
					end,
				},
			}
		end
	},

	{ -- Autocompletion
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				'L3MON4D3/LuaSnip',
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
						return
					end
					return 'make install_jsregexp'
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					-- {
					--   'rafamadriz/friendly-snippets',
					--   config = function()
					--     require('luasnip.loaders.from_vscode').lazy_load()
					--   end,
					-- },
				},
			},
			'saadparwaiz1/cmp_luasnip',

			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
		},
		config = function()
			-- See `:help cmp`
			local cmp = require 'cmp'
			local luasnip = require 'luasnip'
			luasnip.config.setup {}
			local lspkind = require('lspkind')

			cmp.setup({
				sources = {
					{
						name = 'lazydev',
						-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
						group_index = 0,
					},
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'path' },
				},
				-- Enable luasnip to handle snippet expansion vor nvim-cmp
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
						-- Think of <c-l> as moving to the right of your snippet expansion.
						--  So if you have a snippet that's like:
						--  function $name($args)
						--    $body
						--  end
						--
						-- <c-l> will move you to the right of each of the expansion locations.
						-- <c-h> is similar, except moving you backwards.
						['<C-l>'] = cmp.mapping(function()
							if luasnip.expand_or_locally_jumpable() then
								luasnip.expand_or_jump()
							end
						end, { 'i', 's' }),
						['<C-h>'] = cmp.mapping(function()
							if luasnip.locally_jumpable(-1) then
								luasnip.jump(-1)
							end
						end, { 'i', 's' }),
					}),
				}),


				-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
				--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
			})
		end,
	},


}
-- 	},
-- 	{
-- 		"akinsho/flutter-tools.nvim",
-- 		dependencies = {
-- 			"nvim-lua/plenary.nvim",
-- 			"stevearc/dressing.nvim",
-- 		},
-- 		config = function()
-- 			require("flutter-tools").setup {
-- 				widget_guides = {
-- 					enabled = false,
-- 				},
-- 				closing_tags = {
-- 					--highlight = "ErrorMsg", -- highlight for the closing tag
-- 					prefix = ">", -- character to use for close tag e.g. > Widget
-- 					enabled = true -- set to false to disable
-- 				},
-- 				outline = {
-- 					open_cmd = "30vnew", -- command to use to open the outline buffer
-- 					auto_open = false -- if true this will open the outline automatically when it is first populated
-- 				},
-- 				lsp = {
-- 					color = { -- show the derived colours for dart variables
-- 						enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
-- 						background = false, -- highlight the background
-- 						background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
-- 						foreground = false, -- highlight the foreground
-- 						virtual_text = true, -- show the highlight using virtual text
-- 						virtual_text_str = "■", -- the virtual text character to highlight
-- 					},
-- 					-- see the link below for details on each option:
-- 					-- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
-- 					settings = {
-- 						showTodos = false,
-- 						completeFunctionCalls = true,
-- 						renameFilesWithClasses = "prompt", -- "always"
-- 						enableSnippets = true,
-- 						lineLength = 160,
-- 						updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
-- 					}
-- 				}
-- 			}
-- 		end,
-- 	},
-- 	{ "folke/neodev.nvim", opts = {} }, -- Helps luals with the vim API
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		lazy = false,
-- 		config = function()
-- 			local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- 			require("neodev").setup({
-- 			}) -- setup neodev before lspconfig!
-- 			local lspconfig = require("lspconfig")
-- 			lspconfig.lua_ls.setup({
-- 				capabilities = capabilities,
-- 			})
-- 			lspconfig.jdtls.setup({
-- 				capabilities = capabilities,
-- 				settings = {
-- 					java = {
-- 						eclipse = { downloadSources = true },
-- 					}
-- 				}
-- 			})
-- 			lspconfig.clangd.setup({
-- 				capabilities = capabilities,
-- 			})
-- 			lspconfig.ltex.setup({
-- 				capabilities = capabilities,
-- 			})
-- 			lspconfig.ruff_lsp.setup({
-- 				capabilities = capabilities,
-- 			})
-- 			lspconfig.pyright.setup({
-- 				capabilities = capabilities,
-- 			})
-- 			lspconfig.sqlls.setup({
-- 				capabilities = capabilities,
-- 				filetypes = { "sql", "mysql" }
-- 			})
-- 			-- lspconfig.pylsp.setup({
-- 			--   capabilities = capabilities,
-- 			--   settings = {
-- 			--     pylsp = {
-- 			--       plugins = {
-- 			--         pycodestyle = {
-- 			--           ignore = { 'W391' },
-- 			--           maxLineLength = 100
-- 			--         }
-- 			--       }
-- 			--     }
-- 			--   },
-- 			-- })
-- 			lspconfig.rust_analyzer.setup({
-- 				capabilities = capabilities,
-- 			})
-- 			lspconfig.gdscript.setup({
-- 				on_attach = on_attach,
-- 				flags = { debounce_text_changes = 150 },
-- 				capabilities = capabilities,
-- 			})
-- 			lspconfig.hls.setup({
-- 				capabilities = capabilities,
-- 			})
-- 			lspconfig.cssls.setup({
-- 				capabilities = capabilities,
-- 			})
-- 			lspconfig.jsonls.setup({
-- 				capabilities = capabilities,
-- 			})
-- 			lspconfig.zls.setup({
-- 				capabilities = capabilities,
-- 			})
-- 			lspconfig.gopls.setup({
-- 				capabilities = capabilities,
-- 				cmd = { "gopls" },
-- 				filetypes = { "go", "gomod", "gowork", "gotmpl" },
-- 			})
-- 			lspconfig.bashls.setup({
-- 				capabilities = capabilities,
-- 			})
-- 			lspconfig.tsserver.setup({
-- 				capabilities = capabilities,
-- 			})
-- 			local wk = require("which-key")
-- 			wk.register({
-- 				c = {
-- 					a = { vim.lsp.buf.code_action, "Code Action" },
-- 					f = { function()
-- 						vim.lsp.buf.format { async = true }
-- 					end, "Format" }
-- 				},
-- 			}, { prefix = "<leader>" })
-- 			vim.diagnostic.config({
-- 				virtual_text = false, -- Inline diagnostics
-- 				signs = true,
-- 				underline = true,
-- 				update_in_insert = false,
-- 				severity_sort = true,
-- 			})
-- 			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
-- 				group = vim.api.nvim_create_augroup("float_diagnostic_cursor", { clear = true }),
-- 				callback = function()
-- 					vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
-- 				end
-- 			})
-- 			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
-- 		end,
-- 	},
-- 	{
-- 		"mfussenegger/nvim-jdtls"
-- 	},
-- 	{
-- 		-- HSplit showing list of errors/warnings in code.
-- 		"https://github.com/folke/trouble.nvim",
-- 		config = function()
-- 			vim.keymap.set("n", "<leader>tt", "<CMD>TroubleToggle<CR>", {})
-- 		end
-- 	}
-- }
