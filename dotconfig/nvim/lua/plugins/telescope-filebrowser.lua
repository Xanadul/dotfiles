return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    require('which-key').add {
      { '<leader>.', ":Telescope file_browser path=%:p:h select_buffer=true grouped=true <CR>", desc = 'File Browser', mode = 'n' },
    }
    require("telescope").setup({
      extensions = {
        file_browser = {
          follow_symlinks = true,
        }
      }
    })
  end
}
