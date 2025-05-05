return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    lazy = true,
    config = false,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      dependencies = {
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
      },
      config = function()
        local ls = require('luasnip')
        require("luasnip.loaders.from_vscode").lazy_load()
        ls.config.set_config {
          history = false,
          updateevents = 'TextChanged,TextChangedI'
        }
        ls.filetype_extend("python", { "pydoc" })

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
          {
            name = 'nvim_lsp',
            entry_filter = function(entry, ctx)
              return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
            end
          },
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
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
          -- delay update diagnostics
          update_in_insert = false,
        }
      )

      -- lsp_attach is where you enable features that only work
      -- if there is a language server active in the file
      local lsp_attach = function(client, bufnr)
        local opts = { buffer = bufnr }
        local wk = require("which-key")
        wk.add({
          { "gK",         '<cmd>lua vim.lsp.buf.hover<cr>',             desc = 'Information' },
          { "gd",         '<cmd>lua vim.lsp.buf.definition()<cr>',      desc = 'to [D]efinition' },
          { "gD",         '<cmd>lua vim.lsp.buf.declaration()<cr>',     desc = 'to [D]eklaration' },
          { "gi",         '<cmd>lua vim.lsp.buf.implementation()<cr>',  desc = 'to [I]mplementations' },
          { "go",         '<cmd>lua vim.lsp.buf.type_definition()<cr>', desc = 'to type definition' },
          { "gr",         '<cmd>lua vim.lsp.buf.references()<cr>',      desc = 'to [R]efereces' },
          { "gs",         '<cmd>lua vim.lsp.buf.signature_help()<cr>',  desc = 'to [Signature]' },
          { "<leader>ca", '<cmd>lua vim.lsp.buf.code_action()<cr>',     desc = '[A]ction' },
          { "<leader>cf", '<cmd>lua vim.lsp.buf.format()<cr>',          desc = '[F]ormat' },
        })
      end

      lsp_zero.extend_lspconfig({
        sign_text = true,
        lsp_attach = lsp_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      })

      -- These are just examples. Replace them with the language
      -- servers you have installed in your system
      require('lspconfig').ruff.setup({})
      require('lspconfig').gopls.setup({})
      require('lspconfig').jdtls.setup({})
      require('lspconfig').pyright.setup({})
      require('lspconfig').nil_ls.setup({})
      require('lspconfig').lua_ls.setup({})
      require('lspconfig').marksman.setup({}) --Markdown
      require('lspconfig').jsonls.setup({})   --https://github.com/hrsh7th/vscode-langservers-extracted
      require('lspconfig').zls.setup({})
      -- require('lspconfig').texlab.setup({})
      require('lspconfig').clangd.setup({})
      require('lspconfig').bashls.setup({})
      require('lspconfig').hyprls.setup({})
      require('lspconfig').ols.setup({})
      require('lspconfig').ltex.setup({
        settings = {
          ltex = {
            language = "en-GB",
          },
        },
      })
      require('lspconfig').kotlin_language_server.setup({})
      require('lspconfig').openscad_lsp.setup({})
      -- require('lspconfig').dartls.setup({})

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

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          require('which-key').add {
            { '<leader>cr', vim.lsp.buf.rename, desc = '[R]ename', mode = 'n' },
          }
        end
      })
    end
  },


  -- Small GUI in lower right for LSP notifications
  { 'j-hui/fidget.nvim',   opts = {} },

  { 'onsails/lspkind.nvim' },


  -- Diagnostics
  {
    "folke/trouble.nvim",
    config = function()
      require('which-key').add({
        { "<leader>tt", '<CMD>TroubleToggle<CR>', desc = '[T]rouble' },
      })
    end
  },

  -- Ledger
  {
    "ledger/vim-ledger"
  },

  -- Flutter (TODO: Fix highlights)
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
          prefix = ">",  -- character to use for close tag e.g. > Widget
          enabled = true -- set to false to disable
        },
        outline = {
          open_cmd = "30vnew", -- command to use to open the outline buffer
          auto_open = false    -- if true this will open the outline automatically when it is first populated
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
        },
        debugger = {

          enabled = true,
          register_configurations = function(paths)
            require("dap").configurations.dart = {

            }
          end
        },
      }
    end,
  },

  -- Better inline diagnostics
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    -- event = "LspAttach", -- Or `LspAttach`
    lazy = false;
    priority = 1000,    -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup()
      vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end
  }

}
