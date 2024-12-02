return {
  "lambdalisue/vim-suda",
  config = function ()
    vim.api.nvim_create_user_command('W', 'SudaWrite', { nargs = 0})
  end
}
