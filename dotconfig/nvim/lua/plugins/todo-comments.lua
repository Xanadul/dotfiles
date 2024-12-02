return {
  "folke/todo-comments.nvim",
  dependencies = {"nvim-lua/plenary.nvim"},
  opts = {
    keywords = {
      WARN = {
        color = "#FF8800"
      },
      NOTE = {
        color = "#baefc4"
      },
      DEFA = {
        color = "#AABBCC",
        alt = {"DEFAULT"},
      }
    },
    highlight = {
      pattern = [[.*(KEYWORDS)\s*]],
      -- DEFAULT:
      -- pattern = [[.*(KEYWORDS)\s*:]],
    }
    -- Examples:
    -- PERF: Unoptimized
    -- HACK: Bit funky
    -- TODO: Change stuff
    -- NOTE: Just some info 
    -- FIX:  this needs fixing
    -- WARN: Oh no...
  },
  vim.keymap.set("n", "<leader>td", "<CMD>TodoTelescope<CR>", {})
}
