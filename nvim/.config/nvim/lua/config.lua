CONFIG_PATH = vim.fn.stdpath("config")
DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")

vim.opt.clipboard = "unnamedplus" -- make NeoVim use the system clipboard
vim.opt.colorcolumn = "100" -- column count indicator
vim.opt.completeopt = { "noinsert", "menuone", "noselect" }
vim.opt.cursorline = true -- highlight the current line
vim.opt.encoding = "utf-8" -- encoding used to write to a file
vim.opt.expandtab = true -- coverts tab to spaces
vim.opt.hidden = true -- keep buffers open in the background
vim.opt.lazyredraw = true -- don't draw until macros and stuff have finished
vim.opt.mouse = "a" -- allow mouse to be used for all modes
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.ruler = false -- don't show ruler
vim.opt.scrolloff = 8 -- line scroll padding
vim.opt.shiftwidth = 4 -- use 4 spaces when something gets indented
vim.opt.shortmess:append({ c = true }) -- don't show pattern not found
vim.opt.showmode = false -- don't show -- INSERT -- and stuff at the bottom
vim.opt.signcolumn = "yes" -- always show the sign column
vim.opt.spelllang = "en_au" -- set spell checker language to Australian English
vim.opt.splitbelow = true -- make horizontal splits to go below current window
vim.opt.splitright = true -- make vertical splits to go to the right of current window
vim.opt.swapfile = false -- no swap file
vim.opt.tabstop = 4 -- use 4 spaces for tab
vim.opt.termguicolors = true -- enable true colour for terminal
vim.opt.timeoutlen = 500 -- timeout to wait for a key combination to complete
vim.opt.undodir = DATA_PATH .. "/undo" -- set an undo directory
vim.opt.undofile = true -- persistent undos
vim.opt.updatetime = 100 -- how often updates happen
vim.opt.wrap = false -- no line wrapping
vim.opt.writebackup = false -- don't make backup files
vim.opt.guifont = "SauceCodePro_Nerd_font:h10"

-- makes indent and tabs better
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true

-- use space as leader key
vim.g.mapleader = " "

vim.api.nvim_command("filetype plugin on")
