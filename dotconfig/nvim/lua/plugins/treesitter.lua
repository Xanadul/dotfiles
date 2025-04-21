return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        vim.treesitter.language.register("bash", "haskell"),
        vim.filetype.add({
          pattern = { [".*/hypr/.*%.conf"] = "hyprlang" }
        })
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    init = function()
      local config = require 'nvim-treesitter.configs';
      config.setup({
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = { query = "@function.outer", desc = "function" },
              ["if"] = { query = "@function.inner", desc = "inner function" },
              ["ac"] = { query = "@class.outer" },
              ["ao"] = { query = "@comment.outer", desc = "comment" },
              ["io"] = { query = "@comment.inner", desc = "inner comment" },
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = { query = "@class.inner", desc = "inner class" },
              -- You can also use captures from other query groups like `locals.scm`
              ["as"] = { query = "@local.scope", query_group = "locals", desc = "language scope" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V',  -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true or false
            include_surrounding_whitespace = true,
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>rs"] = { query = "@parameter.inner", desc = "Swap with next parameter" },
              ["<C-right>"] = { query = "@parameter.inner", desc = "Swap with next parameter" },
              ["<C-down>"] = { query = "@parameter.inner", desc = "Swap with next parameter" },
            },
            swap_previous = {
              ["<leader>rS"] = { query = "@parameter.inner", desc = "Swap with previous parameter" },
              ["<C-left>"] = { query = "@parameter.inner", desc = "Swap with previous parameter" },
              ["<C-up>"] = { query = "@parameter.inner", desc = "Swap with previous parameter" },
            },
          },
        },
      });
    end
  },
}
