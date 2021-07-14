define_augroup("commentary", {
    [[FileType asm setlocal commentstring=;\ %s]],
    [[FileType javascript,typescript,typescriptreact,cpp,c setlocal commentstring=//\ %s]],
})
