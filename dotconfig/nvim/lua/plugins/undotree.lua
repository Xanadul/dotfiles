return {
  'mbbill/undotree',
  config = function()
    require('which-key').add {
      { '<leader>tu', vim.cmd.UndotreeToggle, desc = '[U]ndotree', mode = 'n' },
    }
  end

}
