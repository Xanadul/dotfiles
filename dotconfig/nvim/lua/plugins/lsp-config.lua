return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
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
        }
      }
    end,
  },
  { "folke/neodev.nvim", opts = {}  }, -- Helps luals with the vim API
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("neodev").setup({
      }) -- setup neodev before lspconfig!
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.jdtls.setup({
        capabilities = capabilities,
      })
      lspconfig.clangd.setup({
        capabilities = capabilities,
      })
      lspconfig.ltex.setup({
        capabilities = capabilities,
      })
      lspconfig.ruff_lsp.setup({
        capabilities = capabilities,
      })
      lspconfig.pyright.setup({
        capabilities = capabilities,
      })
      lspconfig.sqlls.setup({
        capabilities = capabilities,
        filetypes = {"sql", "mysql"}
      })
      -- lspconfig.pylsp.setup({
      --   capabilities = capabilities,
      --   settings = {
      --     pylsp = {
      --       plugins = {
      --         pycodestyle = {
      --           ignore = { 'W391' },
      --           maxLineLength = 100
      --         }
      --       }
      --     }
      --   },
      -- })
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
      })
      lspconfig.gdscript.setup({
        on_attach = on_attach,
        flags = { debounce_text_changes = 150 },
        capabilities = capabilities,
      })
      lspconfig.hls.setup({
        capabilities = capabilities,
      })
      lspconfig.cssls.setup({
        capabilities = capabilities,
      })
      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })
      lspconfig.gopls.setup({
        capabilities = capabilities,
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
      })
      lspconfig.bashls.setup({
        capabilities = capabilities,
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities,
      })
      local wk = require("which-key")
      wk.register({
        c = {
          a = { vim.lsp.buf.code_action, "Code Action" },
          f = { function()
            vim.lsp.buf.format { async = true }
          end, "Format" }
        },
      }, { prefix = "<leader>" })
      vim.diagnostic.config({
        virtual_text = false, -- Inline diagnostics
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = vim.api.nvim_create_augroup("float_diagnostic_cursor", { clear = true }),
        callback = function ()
          vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
        end
      })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
    end,
  },
  {
    "mfussenegger/nvim-jdtls"
  },
  {
    -- HSplit showing list of errors/warnings in code.
    "https://github.com/folke/trouble.nvim",
    config = function ()
      vim.keymap.set("n", "<leader>tt", "<CMD>TroubleToggle<CR>", {})
    end 
  }
}
