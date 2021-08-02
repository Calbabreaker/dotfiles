-- automatically get packer (plugin manager)
local install_path = DATA_PATH.."/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.api.nvim_command("packadd packer.nvim")
end

return require("packer").startup(function()
    use "wbthomason/packer.nvim" -- packer plugin stuff
    use "nvim-lua/plenary.nvim" -- lua utils
    use "kyazdani42/nvim-web-devicons" -- nice icons
    use "airblade/vim-rooter" -- change cwd to project root directory

    -- start menu
    use "mhinz/vim-startify"

    -- git changes markings
    use {
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        config = function()
            require("gitsigns").setup()
        end
    }

    -- cool status line
    use {
        "hoob3rt/lualine.nvim",
        event = "BufWinEnter",
        config = function()
            require "pconf/lualine"
        end
    }

    -- nice git integration
    use {
        "tpope/vim-fugitive",
        cmd = { "Git", "Gread" },
    }

    -- colour theme
    use {
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd "colorscheme tokyonight"
        end,
    }

    -- file explorer
    use {
        "kyazdani42/nvim-tree.lua",
        cmd = "NvimTreeToggle",
        config = function()
            require "pconf/tree"
        end,
    }

    -- formatter
    use {
        "mhartington/formatter.nvim",
        config = function()
            require "pconf/formatter"
        end,
    }

    -- fuzzy finding
    use {
        "nvim-telescope/telescope.nvim",
        requires = "nvim-lua/popup.nvim",
        config = function()
            require "pconf/telescope"
        end,
    }

    -- emmet integration
    use {
        "mattn/emmet-vim",
        event = "VimEnter",
        config = function()
            vim.g.user_emmet_mode = "n"
            vim.g.user_emmet_leader_key = ","
        end,
    }

    -- personal wiki and note taking thing
    use {
        "vimwiki/vimwiki",
        event = "VimEnter",
    }

    --
    -- Language server
    --

    use "neovim/nvim-lspconfig"

    -- autocomplete
    use {
        "hrsh7th/nvim-compe",
        event = "InsertEnter",
        config = function()
            require "pconf/compe"
        end,
    }

    -- pairs
    use {
        "windwp/nvim-autopairs",
        after = "nvim-compe",
        config = function()
            require("pconf/other").autopairs()
        end,
    }

    -- auto install language servers
    use {
        "williamboman/nvim-lsp-installer",
        event = "VimEnter",
        config = function()
            require "pconf/lsp-installer"
        end,
    }

    -- nice syntax highlight
    use {
        "nvim-treesitter/nvim-treesitter",
        requires = {
            { "p00f/nvim-ts-rainbow"},
            { "JoosepAlviste/nvim-ts-context-commentstring"},
        },
        config = function()
            require "pconf/treesitter"
        end,
    }


    -- snippets
    use {
        "hrsh7th/vim-vsnip",
        after = "nvim-compe",
    }

    --
    -- Small qol plugins
    --

    -- clipboard history
    use {
        "svermeulen/vim-yoink",
        event = "VimEnter",
        config = function()
            require "pconf/yoink"
        end,
    }

    -- highlight colours eg #1f4a90 rgb(255, 255, 0)
    use {
        "norcalli/nvim-colorizer.lua",
        event = "BufWinEnter",
        config = function()
            require("pconf/other").colorizer()
        end,
    }

    use {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufWinEnter",
        config = function()
            require("pconf/other").blankline()
        end,
    }

    -- easily jump to text and do stuff with it
    use {
        "justinmk/vim-sneak",
        config = function()
            require("pconf/other").sneak()
        end,
    }

    use "christoomey/vim-sort-motion" -- sorts lines
    use "tpope/vim-repeat" -- able to repeat plugin maps
    use "tpope/vim-surround" -- easily edit (), "", etc
    use "tpope/vim-commentary" -- toggle comments with motions
    use "vim-scripts/replacewithregister" -- use motion to replace with clipboard

    use "kana/vim-textobj-user" -- text object library base

    use "kana/vim-textobj-entire" -- text object e for entire file
    use "kana/vim-textobj-indent" -- text object i for indents
    use "sgur/vim-textobj-parameter" -- text object , for function parameters
end)
