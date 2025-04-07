local function is_normal()
    return not MINIMAL
end

local plugins = {
    { "folke/lazy.nvim" },              -- plugin manager stuff
    { "kyazdani42/nvim-web-devicons" }, -- nice icons
    { "nvim-lua/plenary.nvim" },

    {
        "navarasu/onedark.nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("configs/other").colorscheme()
        end,
    },

    -- start menu
    {
        "goolord/alpha-nvim",
        event = "BufWinEnter",
        enabled = is_normal,
        config = function()
            require("configs/alpha")
        end,
    },

    -- git changes markings
    {
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        config = function()
            require("gitsigns").setup({})
        end,
    },

    {
        "f-person/git-blame.nvim",
        event = "BufRead",
        cond = is_normal,
        config = function()
            require("gitblame").setup({ enabled = false })
        end,
    },

    -- cool status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            { "nvim-lua/lsp-status.nvim" }
        },
        event = "BufWinEnter",
        config = function()
            require("configs/lualine")
        end,
    },

    -- nice tabs
    {
        "akinsho/bufferline.nvim",
        config = function()
            require("configs/bufferline")
        end,
    },

    -- file explorer
    {
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("configs/tree")
        end,
    },

    -- fuzzy finding
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-telescope/telescope-fzy-native.nvim" },
        cmd = { "Telescope" },
        config = function()
            require("configs/telescope")
        end,
    },

    -- show keybinds
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({
                win = { border = "double" },
            })
        end,
    },

    -- nice emmet support
    {
        "https://github.com/mattn/emmet-vim",
        event = "BufRead",
        setup = function()
            vim.g.user_emmet_leader_key = ","
            vim.g.user_emmet_mode = "nv"
        end,
    },

    --
    -- Language server
    --

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", },
            { "williamboman/mason-lspconfig.nvim", },
            { "b0o/schemastore.nvim", },
            -- lsp linters and formatter
            {
                "https://github.com/nvimtools/none-ls.nvim",
                config = function()
                    require("configs/null-ls").setup()
                end,
            },
            {
                "nvim-lua/lsp-status.nvim",
                config = function()
                    require("lsp-status").register_progress()
                end
            },
            -- Better lsp
            {
                "nvimdev/lspsaga.nvim",
                cmd = "Lspsaga",
                config = function()
                    require("configs/other").lspsaga()
                end,
            },
            {
                "windwp/nvim-autopairs",
                config = function()
                    require("configs/other").autopairs()
                end,
            }
        },
        enabled = is_normal,
        config = function()
            require("configs/lspconfig")
        end,
    },


    -- autocomplete
    {
        "hrsh7th/nvim-cmp",
        enabled = is_normal,
        event = "InsertEnter",
        dependencies = {
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-buffer" },
        },
        config = function()
            require("configs/cmp")
        end,
    },

    -- view parameters and signatures
    {
        "ray-x/lsp_signature.nvim",
        enabled = is_normal,
        config = function()
            require("lsp_signature").setup()
        end,
    },

    -- snippet support
    {
        "L3MON4D3/LuaSnip",
        dependencies = { { "rafamadriz/friendly-snippets" } },
        event = "InsertEnter",
        config = function()
            require("configs/luasnip")
        end,
    },

    -- nice treesitter syntax highlight and other stuff
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            { "JoosepAlviste/nvim-ts-context-commentstring" },
            { "nvim-treesitter/nvim-treesitter-context" },
        },
        config = function()
            require("configs/other").treesitter()
            vim.api.nvim_command("TSUpdate")
        end,
    },

    --
    -- Small qol plugins
    --

    -- better terminal support
    {
        "akinsho/nvim-toggleterm.lua",
        config = function()
            require("configs/other").toggleterm()
        end,
    },

    -- highlight colours eg: #1f4a90 rgb(255, 255, 0)
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("configs/other").colorizer()
        end,
    },

    -- indent indicators
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufWinEnter",
        config = function()
            require("configs/other").blankline()
        end,
    },

    -- better project management
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup({
                detection_methods = { "pattern" },
                patterns = { ".git", ".project", "Makefile" },
            })
        end,
    },

    {
        "saecki/crates.nvim",
        event = "BufRead Cargo.toml",
        config = function()
            require("crates").setup({})
        end,
    },

    -- nice text objects
    {
        "kana/vim-textobj-user",
        requires = {
            "sgur/vim-textobj-parameter",
            "kana/vim-textobj-entire",
        },
    },

    { "christoomey/vim-sort-motion" },     -- sorts lines
    { "tpope/vim-repeat" },                -- able to repeat plugin maps
    { "tpope/vim-surround" },              -- easily edit and make (), "", etc
    { "tpope/vim-commentary" },            -- toggle comments with motions
    { "vim-scripts/replacewithregister" }, -- provides gr to replace with clipboard
}

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = plugins,
})
