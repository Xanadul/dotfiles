return {
  'kevinhwang91/nvim-ufo',
  requires = 'kevinhwang91/promise-async',
  dependencies = 'kevinhwang91/promise-async',

  -- Manage folds as usual, with z...

  config = function()
    vim.o.foldcolumn = '0' -- '0' is no column
    vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end
    })
  end
}
