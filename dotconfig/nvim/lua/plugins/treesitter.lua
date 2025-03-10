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
          pattern = {[".*/hypr/.*%.conf"] = "hyprlang"}
        })
      })
    end
  }
}
