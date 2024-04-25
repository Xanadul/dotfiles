return {
  "folke/todo-comments.nvim",
  dependencies = {"nvim-lua/plenary.nvim"},
  opts = {
    -- Examples:
    -- PERF: Unoptimized
    -- HACK: Bit funky
    -- TODO: Change stuff
    -- NOTE: Just some info 
    -- FIX:  this needs fixing
    -- WARNING: Oh no...
  },
  vim.keymap.set("n", "<leader>tt", "<CMD>TodoTelescope<CR>", {})
}
