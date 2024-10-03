local function plugin_setup(use)
    use("wbthomason/packer.nvim")       -- packer plugin stuff
    use("kyazdani42/nvim-web-devicons") -- nice icons
    use("nvim-lua/plenary.nvim")        -- lua utils
    use("lewis6991/impatient.nvim")     -- improve neovim startup times

    -- colour scheme
    use({
        "navarasu/onedark.nvim",
        config = function()
            require("configs/other").colorscheme()
        end,
    })

    -- start menu
    use({
        "goolord/alpha-nvim",
        event = "BufWinEnter",
        cond = "not MINIMAL",
        config = function()
            require("configs/alpha")
        end,
    })

    -- git changes markings
    use({
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        config = function()
            require("gitsigns").setup({})
        end,
    })

    use({
        "f-person/git-blame.nvim",
        event = "BufRead",
        cond = "not MINIMAL",
        config = function()
            require("gitsigns").setup({ enabled = false })
        end,
    })

    -- cool status line
    use({
        "nvim-lualine/lualine.nvim",
        event = "BufWinEnter",
        config = function()
            require("configs/lualine")
        end,
    })

    -- nice tabs
    use({
        "akinsho/bufferline.nvim",
        config = function()
            require("configs/bufferline")
        end,
    })

    -- file explorer
    use({
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("configs/tree")
        end,
    })

    -- fuzzy finding
    use({
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-telescope/telescope-fzy-native.nvim" },
        cmd = { "Telescope" },
        config = function()
            require("configs/telescope")
        end,
    })

    -- show keybinds
    use({
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({
                win = { border = "double" },
            })
        end,
    })

    -- nice emmet support
    use({
        "https://github.com/mattn/emmet-vim",
        event = "BufRead",
        setup = function()
            vim.g.user_emmet_leader_key = ","
            vim.g.user_emmet_mode = "nv"
        end,
    })

    --
    -- Language server
    --

    use({
        "neovim/nvim-lspconfig",
        requires = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "b0o/schemastore.nvim",
            "nvim-lua/lsp-status.nvim",
        },
        cond = "not MINIMAL",
        config = function()
            require("configs/lspconfig")
        end,
    })

    -- lsp linters and formatter
    use({
        "jose-elias-alvarez/null-ls.nvim",
        after = "nvim-lspconfig",
        config = function()
            require("configs/null-ls")
        end,
    })

    -- autocomplete
    use({
        "hrsh7th/nvim-cmp",
        cond = "not MINIMAL",
        event = "InsertEnter",
        config = function()
            require("configs/cmp")
        end,
    })

    use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })

    -- view parameters and signatures
    use({
        "ray-x/lsp_signature.nvim",
        cond = "not MINIMAL",
        config = function()
            require("lsp_signature").setup()
        end,
    })

    -- snippet support
    use({
        "L3MON4D3/LuaSnip",
        requires = "rafamadriz/friendly-snippets",
        event = "InsertEnter",
        config = function()
            require("configs/luasnip")
        end,
    })

    use({
        "windwp/nvim-autopairs",
        after = "nvim-cmp",
        config = function()
            require("configs/other").autopairs()
        end,
    })

    -- nice syntax highlight
    use({
        "nvim-treesitter/nvim-treesitter",
        requires = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter-context",
        },
        config = function()
            require("configs/other").treesitter()
        end,
        run = ":TSUpdate",
    })

    --
    -- Small qol plugins
    --

    -- better terminal support
    use({
        "akinsho/nvim-toggleterm.lua",
        config = function()
            require("configs/other").toggleterm()
        end,
    })

    -- highlight colours eg: #1f4a90 rgb(255, 255, 0)
    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("configs/other").colorizer()
        end,
    })

    -- indent indicators
    use({
        "lukas-reineke/indent-blankline.nvim",
        event = "BufWinEnter",
        config = function()
            require("configs/other").blankline()
        end,
    })

    -- better project management
    use({
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup({
                detection_methods = { "pattern" },
                patterns = { ".git", ".project" },
            })
        end,
    })

    -- nice text objects
    use({
        "kana/vim-textobj-user",
        requires = {
            "sgur/vim-textobj-parameter",
            "kana/vim-textobj-entire",
        },
    })

    use("christoomey/vim-sort-motion")     -- sorts lines
    use("tpope/vim-repeat")                -- able to repeat plugin maps
    use("tpope/vim-surround")              -- easily edit and make (), "", etc
    use("tpope/vim-commentary")            -- toggle comments with motions
    use("vim-scripts/replacewithregister") -- provides gr to replace with clipboard
end

-- automatically get packer (plugin manager)
local install_path = DATA_PATH .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({
        "git",
        "clone",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
        "--depth=1",
    })
    vim.api.nvim_command("packadd packer.nvim")
end

require("packer").startup({
    function(use)
        plugin_setup(use)
        if PACKER_BOOTSTRAP then
            require("packer").sync()
        end
    end,
    config = {
        git = {
            subcommands = {
                -- more efficient than default
                fetch = "fetch --no-tags --no-recurse-submodules --update-shallow --progress",
            },
        },
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "rounded" })
            end,
        },
    },
})
