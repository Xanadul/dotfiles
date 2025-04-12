return {
  -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').add {
      { '<leader>c',   group = '[C]ode' },
      { "<leader>ca",  '<cmd>lua vim.lsp.buf.code_action()<cr>',               desc = '[A]ction' },
      { '<leader>cc',  group = '[Code]/[C]alls' },
      { '<leader>f',   group = '[F]ind' },
      { '<leader>b',   group = '[B]uffers' },
      { '<leader>d',   group = '[D]ocument' },
      { '<leader>r',   group = '[R]ename' },
      { '<leader>w',   group = '[W]orkspace' },
      { '<leader>t',   group = '[T]oggle' },
      { "g",           group = "[G]o" },
      { "<leader>e",   group = "[E]dit" },
      { '<leader>h',   group = 'Git [H]unk',                                   mode = { 'n', 'v' } },

      -- Navigate vim panes better
      { "<c-Left>",    ":wincmd h<CR>" },
      { "<c-Down>",    ":wincmd j<CR>" },
      { "<c-Up>",      ":wincmd k<CR>" },
      { "<c-Right>",   ":wincmd l<CR>" },
      { "<c-h>",       ":wincmd h<CR>" },
      { "<c-j>",       ":wincmd j<CR>" },
      { "<c-k>",       ":wincmd k<CR>" },
      { "<c-l>",       ":wincmd l<CR>" },

      -- Create and resize panes
      { "<leader>wh",  ':vsplit<CR>',                                          desc = "Split right" },
      { "<leader>wv",  ':split<CR>',                                           desc = "Split down" },
      { "<leader>wc",  ':quit<CR>',                                            desc = "Close split" },
      { "<C-S-Up>",    ':resize +1<CR>',                                       desc = "Increase H Split Size" },
      { "<C-S-Down>",  ':resize -1<CR>',                                       desc = "Decrease H Split Size" },
      { "<C-S-Left>",  ':vertical resize -1<CR>',                              desc = "Decrease V Split Size" },
      { "<C-S-Right>", ':vertical resize +1<CR>',                              desc = "Increase V Split Size" },
      { "<C-S-k>",     ':resize +1<CR>',                                       desc = "Increase H Split Size" },
      { "<C-S-j>",     ':resize -1<CR>',                                       desc = "Decrease H Split Size" },
      { "<C-S-h>",     ':vertical resize -1<CR>',                              desc = "Decrease V Split Size" },
      { "<C-S-l>",     ':vertical resize +1<CR>',                              desc = "Increase V Split Size" },

      -- Close Buffer (If saved)
      { "<leader>bc",  ':enew<bar>bd #<CR>',                                   desc = "[C]lose" },


      { "<leader>o",   "o<esc>",                                               desc = "Newline on top" },
      { "<leader>O",   "O<esc>",                                               desc = "Newline below" },

      { "J",           "mzJ`z",                                                desc = "J but static cursor" },
      { "<C-d>",       "<C-d>zz",                                              desc = "Half Page Jump" },
      { "<C-u>",       "<C-u>zz",                                              desc = "Half Page Jump" },
      { "n",           "nzzzv" },
      { "N",           "Nzzzv" },

      -- next greatest remap ever : asbjornHaland
      { "<leader>p",   [["dP]],                                                desc = "Cut to Void" },

      -- greatest remap ever
      { "<leader>y",   [["+y]],                                                desc = "Yank to Clipboard" },
      { "<leader>Y",   [["+Y]],                                                desc = "Yank to system Clipboard" },

      -- delete to void
      { "<leader>d",   [["_d]],                                                desc = "Delete to void",          mode = { "v", "n" } },
      { "Q",           "<nop>",                                                mode = "v" },

      -- Relace word in Document
      { "<leader>s",   [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "Replace Word in Doc" },

      -- Make executable
      { "<leader>x",   "<cmd>!chmod +x %<CR>",                                 silent = true,                    desc = "cmod +x" },
    }
  end,
}
