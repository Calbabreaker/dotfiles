vim.o.clipboard = "unnamedplus" -- make NeoVim use the system clipboard
vim.o.colorcolumn = "100" -- column count indicator
vim.o.completeopt = "noinsert,menuone,noselect"
vim.o.cursorline = true -- highlight the current line
vim.o.encoding = "utf-8" -- encoding used to write to a file
vim.o.expandtab = true -- coverts tab to spaces
vim.o.hidden = true -- keep buffers open in the background
vim.o.lazyredraw = true -- don't draw until macros and stuff have finished
vim.o.mouse = "a" -- allow mouse to be used for all modes
vim.o.number = true -- show line numbers
vim.o.relativenumber = true -- show relative line numbers
vim.o.scrolloff = 8 -- line scroll padding
vim.o.shiftwidth = 4 -- use 4 spaces when something gets indented
vim.o.shortmess = vim.o.shortmess.."c" -- don't show "pattern not found"
vim.o.showmode = false -- don't show -- INSERT -- and stuff at the bottom
vim.o.showtabline = 2 -- always show buffer tabs
vim.o.signcolumn = "yes" -- always show the sign column
vim.o.spelllang = "en_au" -- set spell checker language to Australian English
vim.o.splitbelow = true -- make horizontal splits to go below current window
vim.o.splitright = true -- make vertical splits to go to the right of current window
vim.o.swapfile = false -- no swap file
vim.o.tabstop = 4 -- use 4 spaces for tab
vim.o.termguicolors = true -- enable true colour for terminal
vim.o.undodir = DATA_PATH.."/undo" -- set an undo directory
vim.o.undofile = true -- persistent undos
vim.o.updatetime = 500 -- how often completion updates happen
vim.o.timeoutlen = 500 -- timeout to wait for a key combination to complete
vim.o.wrap = false -- no line wrapping
vim.o.writebackup = true -- don't make backup files

-- makes indent and tabs better
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.smarttab = true

-- use space as leader key
vim.g.mapleader = " "

vim.cmd "filetype plugin on"
