return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require('which-key').add {
      { '<leader>td', "<CMD>TodoTelescope<CR>", desc = 'To[D]o Telescope', mode = 'n' },
    }
  end,
  opts = {
    keywords = {
      TODO = {
        color = "#5577CC"
      },
      WARN = {
        color = "#FF8800"
      },
      NOTE = {
        color = "#baefc4"
      },
      DEFA = {
        color = "#AABBCC",
        alt = { "DEFAULT" },
      },
      -- TODO Disable highligt for adjacent characters, so that the number after eg. RIDKOM-852 is not highlighted
      -- RIDKOM = { --This name to avoid highlighting the commonly used RIDKOM
      --   color = "#5577FF",
      --   alt = {"ZVD", "RI-DKOM"}, --To match on jira ids, eg RIDKOM-852
      -- }
    },
    highlight = {
      keyword = "",
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
}
