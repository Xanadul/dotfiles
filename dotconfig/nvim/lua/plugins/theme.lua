local dracula = {
  "dracula/vim",
  lazy = false,
  name = "dracula",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "dracula"
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end
}

local catppuccinLatte = {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        --lualine = true
        },
    })
    vim.cmd.colorscheme "catppuccin-latte"
    --vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end
}

local tokyonight = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function ()
    require("tokyonight").setup({
      style = "moon", --used by eg. lualine 
      light_style = "day",
      transparent = true,
      vim.cmd.colorscheme "tokyonight-moon",
    })
  end
}

return { tokyonight }
