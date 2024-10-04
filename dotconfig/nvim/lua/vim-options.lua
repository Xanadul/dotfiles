local opt = vim.opt
local keyset = vim.keymap.set

vim.g.mapleader = " "


-- Tab / Indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2    -- use << or >> to inc/decrease indent
opt.expandtab = false -- true enables spaces for indent
opt.smartindent = true
opt.wrap = false


--opt.timeoutlen = 300


-- Search
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Appearance
vim.g.have_nerd_font = true
opt.termguicolors = true
opt.relativenumber = true
vim.wo.number = true -- Relative line numbers
opt.colorcolumn = "160"
opt.signcolumn = "yes"
opt.guicursor = ""
opt.nu = true
<<<<<<< HEAD
opt.scrolloff = 10
opt.completeopt = { "menuone", "noinsert", "noselect" }
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.inccommand = 'split'
opt.cursorline = true
=======
opt.scrolloff = 8
opt.completeopt = { "menuone", "noinsert", "noselect" }
>>>>>>> 17f6aff60acca21940ff9dfc24e61a06da9d6d64

-- Behaviour
opt.swapfile = false
opt.backup = false
opt.undodir = {os.getenv("HOME") .. "/.vim/undodir"}
opt.undofile = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.breakindent = true
opt.iskeyword:append("-")
opt.mouse:append('a')
opt.isfname:append("@-@")
opt.updatetime = 250
opt.encoding = "UTF-8"




-- Spellcheck
--keyset("n", "<leader>tse", ":setlocal spell spelllang=en_gb,de<CR>")
--keyset("n", "<leader>tsd", ":setlocal spell! spelllang=en_gb,de<CR>")

-- Navigate vim panes better
keyset("n", "<c-Left>", ":wincmd h<CR>")
keyset("n", "<c-Down>", ":wincmd j<CR>")
keyset("n", "<c-Up>", ":wincmd k<CR>")
keyset("n", "<c-Right>", ":wincmd l<CR>")

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

<<<<<<< HEAD


=======
>>>>>>> 17f6aff60acca21940ff9dfc24e61a06da9d6d64
keyset("v", "<S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move Line Down", silent = true })
keyset("v", "<S-Up>", ":m '<-2<CR>gv=gv", { desc = "Move Line Up", silent = true })
keyset("n", "<leader>o", "o<esc>", { desc = "Newline on top" })
keyset("n", "<leader>O", "O<esc>", { desc = "Newline below" })

keyset("n", "J", "mzJ`z", { desc = "J but static cursor" })
keyset("n", "<C-d>", "<C-d>zz", { desc = "Half Page Jump" })
keyset("n", "<C-u>", "<C-u>zz", { desc = "Half Page Jump" })
keyset("n", "n", "nzzzv")
keyset("n", "N", "Nzzzv")

-- greatest remap ever
keyset("x", "<leader>p", [["dP]], { desc = "Cut to Void" })

-- next greatest remap ever : asbjornHaland
keyset({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to Clipboard" })
<<<<<<< HEAD

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

=======
>>>>>>> 17f6aff60acca21940ff9dfc24e61a06da9d6d64
keyset("n", "<leader>Y", [["+Y]], { desc = "Some kinda Yank" })

keyset({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void" })

-- This is going to get me cancelled
keyset("i", "<C-c>", "<Esc>")

keyset("n", "Q", "<nop>")

--quickfix stuff
--keyset("n", "<C-k>", "<cmd>cnext<CR>zz")
--keyset("n", "<C-j>", "<cmd>cprev<CR>zz")
--keyset("n", "<leader>k", "<cmd>lnext<CR>zz")
--keyset("n", "<leader>j", "<cmd>lprev<CR>zz")

keyset(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace Word in Doc" }
)
keyset("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "cmod +x" })


--Easy indent usin > and <
keyset("v", ">", ">gv")
keyset("v", "<", "<gv")
