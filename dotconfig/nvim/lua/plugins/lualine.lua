return {
  -- Fancy status line
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = "dracula", -- If you change your theme in theme.lua, you might wanna change this too
      },
    })
  end,
}
