local opt = vim.opt
function toggleWrap()
  if opt.wrap == true then
    opt.nowrap = true
  else
    opt.wrap = true
  end
end

function incTabWidth()
  opt.tabstop = opt.tabstop + 1
  opt.softtabstop = opt.softtabstop + 1
  opt.shiftwidth = opt.shiftwidth + 1
end

function decTabWidth()
  opt.tabstop = opt.tabstop - 1
  opt.softtabstop = opt.softtabstop - 1
  opt.shiftwidth = opt.shiftwidth - 1
end

return {
  -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').add {
      { '<leader>c',   group = '[C]ode' },
      { "<leader>ca",  '<cmd>lua vim.lsp.buf.code_action()<cr>',     desc = '[A]ction' },
      { '<leader>cc',  group = '[Code]/[C]alls' },
      { '<leader>f',   group = '[F]ind' },
      { '<leader>h',   group = '[H]op' },
      { '<leader>b',   group = '[B]uffers' },
      { '<leader>r',   group = '[R]ename' },
      { '<leader>w',   group = '[W]orkspace' },
      { '<leader>t',   group = '[T]oggle' },
      { "g",           group = "[G]o" },
      { "<leader>e",   group = "[E]dit" },

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
      { "<leader>wh",  ':vsplit<CR>',                                desc = "Split right" },
      { "<leader>wv",  ':split<CR>',                                 desc = "Split down" },
      { "<leader>wc",  ':quit<CR>',                                  desc = "Close split" },
      { "<C-S-Up>",    ':resize +1<CR>',                             desc = "Increase H Split Size" },
      { "<C-S-Down>",  ':resize -1<CR>',                             desc = "Decrease H Split Size" },
      { "<C-S-Left>",  ':vertical resize -1<CR>',                    desc = "Decrease V Split Size" },
      { "<C-S-Right>", ':vertical resize +1<CR>',                    desc = "Increase V Split Size" },
      { "<C-S-k>",     ':resize +1<CR>',                             desc = "Increase H Split Size" },
      { "<C-S-j>",     ':resize -1<CR>',                             desc = "Decrease H Split Size" },
      { "<C-S-h>",     ':vertical resize -1<CR>',                    desc = "Decrease V Split Size" },
      { "<C-S-l>",     ':vertical resize +1<CR>',                    desc = "Increase V Split Size" },

      -- Close Buffer (If saved)
      { "<leader>bc",  ':enew<bar>bd #<CR>',                         desc = "[C]lose" },


      { "<leader>o",   "o<esc>",                                     desc = "Newline on top",       silent = true },
      { "<leader>O",   "O<esc>",                                     desc = "Newline below",        silent = true },

      { "<leader>+",   incTabWidth,                                  desc = "Increase Tab Width" },
      { "<leader>-",   decTabWidth,                                  desc = "Decrease Tab Width" },
      { "<leader>tw",  toggleWrap,                                   desc = "Toggle linewrap" },

      -- LSP commands
      { "k",           '<cmd>lua vim.lsp.buf.hover()<cr>',           desc = 'Information' },
      { "K",           '<cmd>lua vim.lsp.buf.hover()<cr>',           desc = 'Information' },
      { "<leader>e",   '<cmd>lua vim.diagnostic.open_float()<cr>',   desc = 'Diagnostics' },
      { "<leader>k",   '<cmd>lua vim.lsp.buf.signature_help()<cr>',  desc = 'Signature' },
      { "gd",          '<cmd>lua vim.lsp.buf.definition()<cr>',      desc = 'to [D]efinition' },
      { "gD",          '<cmd>lua vim.lsp.buf.declaration()<cr>',     desc = 'to [D]eklaration' },
      { "gi",          '<cmd>lua vim.lsp.buf.implementation()<cr>',  desc = 'to [I]mplementations' },
      { "go",          '<cmd>lua vim.lsp.buf.type_definition()<cr>', desc = 'to type definition' },
      { "gr",          '<cmd>lua vim.lsp.buf.references()<cr>',      desc = 'to [R]efereces' },
      { "gs",          '<cmd>lua vim.lsp.buf.signature_help()<cr>',  desc = 'to [Signature]' },
      { "<leader>ca",  '<cmd>lua vim.lsp.buf.code_action()<cr>',     desc = '[A]ction' },
      { "<leader>cf",  '<cmd>lua vim.lsp.buf.format()<cr>',          desc = '[F]ormat' },
      { "<leader>cr",  '<cmd>lua vim.lsp.buf.rename()<cr>',          desc = '[R]ename' },
    }
  end,
}
