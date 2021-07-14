register_mappings("tn", { noremap = true, silent = true }, {
    -- move to previous/next
    { "<A-,>", ":BufferPrevious<CR>" },
    { "<A-.>", ":BufferNext<CR>" },

    -- re-order to previous/next
    { "<A-<>", ":BufferMovePrevious<CR>" },
    { "<A->>", ":BufferMoveNext<CR>" },

    -- goto buffer at position
    { "<A-1>", ":BufferGoto 1<CR>" },
    { "<A-2>", ":BufferGoto 2<CR>" },
    { "<A-3>", ":BufferGoto 3<CR>" },
    { "<A-4>", ":BufferGoto 4<CR>" },
    { "<A-5>", ":BufferGoto 5<CR>" },
    { "<A-6>", ":BufferGoto 6<CR>" },
    { "<A-7>", ":BufferGoto 7<CR>" },
    { "<A-8>", ":BufferGoto 8<CR>" },
    { "<A-9>", ":BufferLast<CR>" },

    -- close buffer
    { "<A-c>", ":BufferClose<CR>" },
    { "<A-C>", ":BufferCloseAllButCurrent<CR>" },

    -- magic buffer picking mode
    { "<C-s>", ":BufferPick<CR>" },
    { "<Leader>bd", ":BufferOrderByDirectory<CR>" },
    { "<Leader>bl", ":BufferOrderByLanguage<CR>" },
})

