local opt = vim.opt
local keyset = vim.keymap.set

-- Space key as leader for key-chords (e.g "<leader>cf" meaning press space, then c, then f)
vim.g.mapleader = " "

-- Tab / Indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2   -- use << or >> to inc/decrease indent
opt.expandtab = true -- true enables spaces for indent
opt.smartindent = true
opt.wrap = true
--opt.timeoutlen = 300




-- Search
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Appearance
vim.g.have_nerd_font = true
opt.termguicolors    = true
opt.relativenumber   = true
vim.wo.number        = true  -- Relative line numbers
opt.colorcolumn      = "110" -- Line at character column 110, purely as indicator for long lines.
opt.signcolumn       = "yes"
opt.guicursor        = ""
opt.nu               = true
opt.scrolloff        = 10 -- Always show 10 lines above/below cursor when scrolling
opt.completeopt      = { "menuone", "noinsert", "noselect" }
opt.list             = true
opt.listchars        = { tab = '» ', trail = '·', nbsp = '␣' }
opt.inccommand       = 'split'
opt.cursorline       = true -- Highlight line of cursor

-- Behaviour
opt.swapfile         = false
opt.backup           = false
opt.undodir          = { os.getenv("HOME") .. "/.vim/undodir" }
opt.undofile         = true
opt.backspace        = "indent,eol,start"
opt.splitright       = true
opt.splitbelow       = true
opt.autochdir        = false
opt.breakindent      = true
opt.iskeyword:append("-")
opt.mouse:append('a')
opt.isfname:append("@-@")
opt.updatetime = 250
opt.encoding = "UTF-8"


keyset("n", "<leader>bc", ':enew<bar>bd #<CR>', { desc = "[C]lose" })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
keyset('n', '<Esc>', '<cmd>nohlsearch<CR>')


keyset("v", "<S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move Line Down", silent = true })
keyset("v", "<S-Up>", ":m '<-2<CR>gv=gv", { desc = "Move Line Up", silent = true })
keyset("v", "<S-Right>", ">gv", { desc = "Move Line Right" })
keyset("v", "<S-Left>", "<gv")

keyset("n", "J", "mzJ`z", { desc = "J but static cursor" })
keyset("n", "<C-d>", "<C-j>zz", { desc = "Half Page Jump" })
keyset("n", "<C-u>", "<C-k>zz", { desc = "Half Page Jump" })
keyset("n", "n", "nzzzv")
keyset("n", "N", "Nzzzv")

-- greatest remap ever
keyset({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to Clipboard" })
keyset({ "n", "v" }, "<leader>Y", [["+Y]], { desc = "Yank to system Clipboard" })

-- next greatest remap ever : asbjornHaland
keyset("n", "<leader>p", [["dP]], { desc = "Cut to Void" })

-- Relace word in Document
keyset("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace Word in Doc" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
