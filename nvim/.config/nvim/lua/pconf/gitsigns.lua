    require("gitsigns").setup()

register_mappings("n", {}, {
    { "<Leader>gg", ":Git<CR>" },
    { "<Leader>gc", ":Git commit<CR>" },
    { "<Leader>gp", ":Git push<CR>" },
    { "<Leader>gh", ":diffget //2<CR>" },
    { "<Leader>gl", ":diffget //3<CR>" },
})
