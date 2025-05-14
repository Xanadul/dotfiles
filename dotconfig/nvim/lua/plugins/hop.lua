return {
  "smoka7/hop.nvim",
  version = "*",
  opts = {
    keys = 'nctaremwpfdohgluk' -- nsra ilvcmei rfkhpwolzcfzql€ßacnfx
  },
  config = function()
    local wk = require("which-key")
    wk.add({
      { "h",          '<cmd>:HopChar1<cr>',      desc = 'HopChar1',             mode = { 'n', 'v' } },
      { "<leader>hc", '<cmd>:HopCamelCase<cr>',  desc = '[C]amelCase',          mode = { 'n', 'v' } },
      { "<leader>hl", '<cmd>:HopLineStart<cr>',  desc = '[L]ineStart',          mode = { 'n', 'v' } },
      { "<leader>hw", '<cmd>:HopWord<cr>',       desc = '[W]ord',               mode = { 'n', 'v' } },
      { "<leader>hn", '<cmd>:HopNodes<cr>',      desc = '[N]odes (Treesitter)', mode = { 'n', 'v' } },
      { "<leader>hp", '<cmd>:HopPasteChar1<cr>', desc = '[P]aste',              mode = { 'n' } },
    })
    require("hop").setup({})
  end

}
