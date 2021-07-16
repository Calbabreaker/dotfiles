vim.g.yoinkSavePersistently = 1
vim.g.yoinkMoveCursorToEndOfPaste = 1
vim.g.yoinkSyncNumberedRegisters = 1

register_mappings("n", {}, {
    { "[y", "<Plug>(YoinkRotateBack)" },
    { "]y", "<Plug>(YoinkRotateForward)" },
    { "y", "<Plug>(YoinkYankPreserveCursorPosition)" },

    { "[p", "<Plug>(YoinkPostPasteSwapBack)" },
    { "]p", "<Plug>(YoinkPostPasteSwapForward)" },
    { "p", "<Plug>(YoinkPaste_p)" },
    { "P", "<Plug>(YoinkPaste_P)" },
})

register_mappings("x", {}, {
    { "p", "<Plug>(YoinkPaste_p)" },
    { "P", "<Plug>(YoinkPaste_P)" },
    { "y", "<Plug>(YoinkYankPreserveCursorPosition)" },
})

