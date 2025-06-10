return {
  "m4xshen/hardtime.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    require('hardtime').setup(
      {
        disabled_keys = {
          ["<Up>"]    = false,
          ["<Down>"]  = false,
          ["<Left>"]  = false,
          ["<Right>"] = false,
        },
        restricted_keys = {
          ["<Up>"]    = { "", "x" },
          ["<Down>"]  = { "", "x" },
          ["<Left>"]  = { "", "x" },
          ["<Right>"] = { "", "x" },
        },
      }
    )

    -- Document existing key chains
    require('which-key').add {
      { "<leader>th", '<cmd>Hardtime toggle<cr>', desc = '[H]ardtime' },
    }
  end
}
