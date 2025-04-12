return {
  {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "debugloop/telescope-undo.nvim",
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
      local wk = require("which-key")
      wk.add({
        { "<leader>b",   group = "[B]uffer" },
        { "<leader>bb",  '<cmd>Telescope buffers sort_lastused=true<cr>', desc = 'Buffer' },
        { "<leader>cci", builtin.lsp_incoming_calls,                      desc = "[I]ncoming" },
        { "<leader>cco", builtin.lsp_outgoing_calls,                      desc = "[O]utgoing" },
        { "<leader>cd",  builtin.lsp_definitions,                         desc = "[D]efinitions" },
        { "<leader>ci",  builtin.lsp_implementations,                     desc = "[I]mplementations" },
        { "<leader>cr",  builtin.lsp_references,                          desc = "[R]eferences" },
        { "<leader>cs",  builtin.lsp_document_symbols,                    desc = "[S]ymbols" },
        { '<leader>ws',  builtin.lsp_dynamic_workspace_symbols,           desc = '[W]orkspace [S]ymbols' },
        { '<leader>D',   builtin.lsp_type_definitions,                    desc = 'Type [D]efinition' },
        { '<leader>gj',  builtin.jumplist,                                desc = '[J]umplist' },
        { '<leader>to',  builtin.vim_options,                             desc = 'Vim [O]ptions' },
        { '<leader>p',   builtin.jumplist,                                desc = '[P]aste Register' },

        -- Find stuff
        { "<leader>fb",  builtin.buffers,                                 desc = "[B]uffers" },
        { "<leader>fc",  builtin.commands,                                desc = "[C]ommand" },
        { "<leader>fff", builtin.find_files,                              desc = "[F]iles" },
        { "<leader>ffo", builtin.oldfiles,                                desc = "[O]ld" },
        { "<leader>fg",  builtin.live_grep,                               desc = "[G]rep" },
        { '<leader>fw',  builtin.grep_string,                             desc = 'current [W]ord' },
        { '<leader>fk',  builtin.keymaps,                                 desc = '[K]eymaps' },
        { "<leader>fh",  builtin.help_tags,                               desc = "[H]elp Tags" },
        { '<leader>fd',  builtin.diagnostics,                             desc = '[D]iagnostics' },
        { '<leader>fr',  builtin.resume,                                  desc = '[R]esume' },
        { '<leader>f.',  builtin.oldfiles,                                desc = 'Recent Files ("." for repeat)' },
      })

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
