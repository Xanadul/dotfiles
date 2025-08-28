return {
  "christoomey/vim-tmux-navigator",
  config = function()
    local wk = require('which-key')
    wk.add({
      { "<m-Left>",  ":TmuxNavigateLeft<CR>" },
      { "<m-Down>",  ":TmuxNavigateDown<CR>" },
      { "<m-Up>",    ":TmuxNavigateUp<CR>" },
      { "<m-Right>", ":TmuxNavigateRight<CR>" },
      { "<c-h>",     ":TmuxNavigateLeft<CR>" },
      { "<c-j>",     ":TmuxNavigateDown<CR>" },
      { "<c-k>",     ":TmuxNavigateUp<CR>" },
      { "<c-l>",     ":TmuxNavigateRight<CR>" },
    })
  end
}
