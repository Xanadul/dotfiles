return { {
  -- Highlight HTML Color codes using the color they represent.
  "NvChad/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup {
      filetypes = { '*', 'org', },
      User_default_options = {
        names = false,
      }
    }
    require('which-key').add {
      { '<leader>tc', ":ColorizerToggle<CR>", desc = '[C]olorizer', mode = 'n' },
    }
  end
} }
