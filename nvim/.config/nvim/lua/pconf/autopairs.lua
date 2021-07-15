require("nvim-autopairs").setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

require("nvim-autopairs.completion.compe").setup({
    map_cr = true, --  map <CR> on insert mode
    map_complete = true, -- it will auto insert `(` after select function or method item
})

-- this probably shouldn't belong here but it is small so whatever
define_augroup("commentary", {
    [[FileType asm setlocal commentstring=;\ %s]],
    [[FileType javascript,typescript,typescriptreact,cpp,c setlocal commentstring=//\ %s]],
})
