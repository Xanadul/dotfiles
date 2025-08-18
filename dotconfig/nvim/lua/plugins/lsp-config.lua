return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'neovim/nvim-lspconfig',
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
          require("luasnip").setup({ enable_audosnippets = true })
          vim.lsp.config('hledger_ls', {
            cmd = { "/usr/bin/hledger-language-server" },
            filetypes = { "ledger", "hledger", "journal" },
            root_dir = require("lspconfig.util").root_pattern(".git", "*.journal"),
            settings = {},
          })

          vim.lsp.enable('hledger')
        end
      },
    },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' }, -- C-y to accept
      snippets = {
        preset = 'luasnip'
      },
      completion = {
        list = {
          selection = {
            auto_insert = false,
          },
        },
        menu = {
          draw = {
            columns = {
              { "kind_icon" },
              { "label",      "label_description", gap = 1 },
              { "kind" },
              { "source_name" },
            }
          }
        },
        documentation = { auto_show = true }
      },
      sources = { default = { 'lsp', 'path', 'snippets' } },
      appearance = {
        nerd_font_variant = 'mono',
        use_nvim_cmp_as_default = true,
      },
    },
    opts_extend = { "sources.default" },
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

  -- Small GUI in lower right for LSP notifications
  { 'j-hui/fidget.nvim', opts = {} },

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
            enableSnippets = false,
            lineLength = 80,
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
    lazy = false,
    priority = 1000, -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup()
      vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end
  },

  {
    "code-biscuits/nvim-biscuits",
    config = function()
      require('nvim-biscuits').setup({
        cursor_line_only = false,
        default_config = {
          max_length = 15,
          min_distance = 5,
          prefix_string = "> ",
        },
        language_config = {
          dart = {
            disabled = true
          },
        },
      })
    end
  }

}
