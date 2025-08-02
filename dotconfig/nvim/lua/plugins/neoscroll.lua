return {
  "karb94/neoscroll.nvim",
  opts = {},
  config = function()
    Ns = require('neoscroll')
    require('which-key').add {
      { '<PageDown>', function() Ns.scroll(0.5, { duration = 300 }) end, mode = 'n', silent = true },
      { '<PageUp>', function() Ns.scroll(-0.5, { duration = 300 }) end, mode = 'n', silent = true },
      -- { '<leader>ew', "<cmd>lua MiniTrailspace.trim()<cr>", desc = '[W]hitespaces remove', mode = 'n' },
    }
  end
}
