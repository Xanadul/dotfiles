return {{
  "NvChad/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup{
      filetypes = {'*', 'org';},
      User_default_options = {
        names = false;
      }
    }
		vim.keymap.set("n", "<leader>tc", ":ColorizerToggle<CR>", { desc = "Colorizer" })
  end
}}
