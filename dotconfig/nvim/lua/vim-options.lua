local keyset        = vim.keymap.set

-- Space key as leader for key-chords (e.g "<leader>cf" meaning press space, then c, then f)
vim.g.mapleader     = " "

-- Tab / Indentation
vim.opt.tabstop     = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth  = 2     -- use << or >> to inc/decrease indent
vim.opt.expandtab   = true -- true enables spaces for indent
vim.opt.smartindent = true
vim.opt.showmode    = false


-- Search
vim.opt.hlsearch   = false
vim.opt.incsearch  = true
vim.opt.ignorecase = true
vim.opt.smartcase  = true
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Appearance
vim.g.have_nerd_font   = true
vim.opt.termguicolors  = true
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.colorcolumn    = "80" -- Line at character column 110, purely as indicator for long lines.
vim.opt.signcolumn     = "yes"
vim.opt.guicursor      = ""
vim.opt.scrolloff      = 999 -- Always show 10 lines above/below cursor when scrolling. NOTE: Also done better by stay-centered.nvim
vim.opt.sidescrolloff  = 999
-- vim.opt.completeopt    = { "menuone", "noinsert", "noselect" }
vim.opt.list           = true
vim.opt.listchars      = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand     = 'split'
vim.opt.cursorline     = true -- Highlight line of cursor
vim.opt.cursorcolumn   = true
vim.opt.wrap           = true
vim.opt.winborder      = "rounded"



-- Behaviour
vim.opt.swapfile    = false
vim.opt.backup      = false
vim.opt.undodir     = { os.getenv("HOME") .. "/.vim/undodir" }
vim.opt.undofile    = true
vim.opt.backspace   = "indent,eol,start"
vim.opt.splitright  = true
vim.opt.splitbelow  = true
vim.opt.autochdir   = false
vim.opt.breakindent = true
vim.opt.updatetime  = 250
vim.opt.encoding    = "UTF-8"
vim.opt.iskeyword:append("-")
vim.opt.mouse:append('a')
vim.opt.isfname:append("@-@")
vim.opt.allowrevins = true -- reverse insert

-- Mouse
vim.o.mouse = ""
vim.o.mousefocus = true
vim.o.mousescroll = "ver:0,hor:0"


-- Keybinds not in whichkey
-- Close Buffer
keyset("n", "<leader>bc", ':enew<bar>bd #<CR>', { desc = "[C]lose" })

keyset("v", "<S-Left>", "<gv", { desc = "Move Line Left" })
keyset("v", "<S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move Line Down", silent = true })
keyset("v", "<S-Up>", ":m '<-2<CR>gv=gv", { desc = "Move Line Up", silent = true })
keyset("v", "<S-Right>", ">gv", { desc = "Move Line Right" })

-- Static jumps, search and J
keyset("n", "J", "mzJ`z", { desc = "J but static cursor" })
-- keyset("n", "<PageDown>", "<C-D>", { desc = "Half Page Jump" })
-- keyset("n", "<PageUp>",   "<C-U>", { desc = "Half Page Jump" })
keyset("n", "n", "nzzzv")
keyset("n", "N", "Nzzzv")

-- greatest remap ever
keyset({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to Clipboard" })
keyset({ "n", "v" }, "<leader>Y", [["+Y]], { desc = "Yank to system Clipboard" })

-- next greatest remap ever : asbjornHaland
keyset({ "n", "v" }, "<leader>d", [["_d]], { desc = "Cut to Void" })

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
vim.lsp.enable('lua_ls')
vim.lsp.enable('ruff')
vim.lsp.enable('pyright')
vim.lsp.enable('gopls')
vim.lsp.enable('jdtls')
vim.lsp.enable('nil_ls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('marksman')
vim.lsp.enable('jsonls')
vim.lsp.enable('zls')
vim.lsp.enable('clangd')
vim.lsp.enable('bashls')
vim.lsp.enable('hyprls')





