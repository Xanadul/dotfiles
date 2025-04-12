local dracula = {
  "dracula/vim",
  lazy = false,
  name = "dracula",
  priority = math.huge,
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

local highlite = {
  "Iron-E/nvim-highlite",
  config = function(_, opts)
    -- OPTIONAL: setup the plugin. See "Configuration" for information
    require('highlite').setup { generator = { plugins = { vim = false }, syntax = false } }

    -- or one of the alternate colorschemes (see the "Built-in Colorschemes" section)
    vim.api.nvim_command 'colorscheme highlite-molokai'
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end,
  lazy = false,
  priority = math.huge,
  version = '^4.0.0',
}

local tokyonight = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    require("tokyonight").setup({
      style = "moon", --used by eg. lualine
      light_style = "day",
      transparent = true,
      vim.cmd.colorscheme "tokyonight-moon",
    })
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end
}

return { dracula } -- Lualine has own setting for Theme, see lualine.lua too
