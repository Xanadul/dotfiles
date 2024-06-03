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
opt.termguicolors = true
opt.relativenumber = true
opt.colorcolumn = "160"
opt.signcolumn = "yes"
opt.guicursor = ""
opt.nu = true
opt.scrolloff = 8
opt.completeopt = { "menuone", "noinsert", "noselect" }

-- Behaviour
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.iskeyword:append("-")
opt.mouse:append('a')
opt.isfname:append("@-@")
opt.updatetime = 50
opt.encoding = "UTF-8"




-- Spellcheck
--keyset("n", "<leader>tse", ":setlocal spell spelllang=en_gb,de<CR>")
--keyset("n", "<leader>tsd", ":setlocal spell! spelllang=en_gb,de<CR>")

-- Navigate vim panes better
keyset("n", "<c-Left>", ":wincmd h<CR>")
keyset("n", "<c-Down>", ":wincmd j<CR>")
keyset("n", "<c-Up>", ":wincmd k<CR>")
keyset("n", "<c-Right>", ":wincmd l<CR>")

vim.wo.number = true -- Relative line numbers

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
