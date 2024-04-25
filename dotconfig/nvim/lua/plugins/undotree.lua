return {
--  diff is not working...
--  'jiaoshijie/undotree',
--  dependencies = 'nvim-lua/plenary.nvim',
--  config = true, 
--  keys = { -- load the plugin only when using it's keybinding:
--    { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
--  },
  'mbbill/undotree',
  config = function ()
    local wk = require("which-key")
    wk.register({
      t = {
        u = {vim.cmd.UndotreeToggle, "Undotree"}
      }
    }, {prefix = "<leader>"})
  end
}
