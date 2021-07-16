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
    use "nvim-lua/popup.nvim" -- popup library

    -- start menu
    use "mhinz/vim-startify"

    -- git changes markings
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("pconf/gitsigns")
        end
    }

    -- cool status line
    use {
        "hoob3rt/lualine.nvim",
        config = function()
            require("pconf/lualine")
        end
    }

    -- nice git integration
    use "tpope/vim-fugitive"

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
        config = function()
            require "pconf/tree"
        end,
    }

    -- cool tabs
    use {
        "akinsho/nvim-bufferline.lua",
        config = function()
            require "pconf/bufferline"
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
        config = function()
            require "pconf/telescope"
        end,
    }

    -- emmet integration
    use "mattn/emmet-vim"

    --
    -- Language server
    --

    use "neovim/nvim-lspconfig"

    -- autocomplete
    use {
        "hrsh7th/nvim-compe",
        config = function()
            require "pconf/compe"
        end,
    }

    -- pairs
    use {
        "windwp/nvim-autopairs",
        config = function()
            require "pconf/autopairs"
        end,
    }

    -- auto install language servers
    use {
        "williamboman/nvim-lsp-installer",
        config = function()
            require "pconf/lsp-installer"
        end,
    }

    -- nice syntax highlight
    use {
        "nvim-treesitter/nvim-treesitter",
        requires = { "p00f/nvim-ts-rainbow", "JoosepAlviste/nvim-ts-context-commentstring" },
        config = function()
            require "pconf/treesitter"
        end,
    }


    -- snippets
    use "hrsh7th/vim-vsnip"

    --
    -- Small qol plugins
    --

    -- clipboard history
    use {
        "svermeulen/vim-yoink",
        config = function()
            require "pconf/yoink"
        end,
    }

    use "ap/vim-css-color" -- show css colors
    use "christoomey/vim-sort-motion" -- sorts lines
    use "tpope/vim-repeat" -- able to repeat plugin maps
    use "tpope/vim-surround" -- easily edit (), "", etc
    use "vim-scripts/replacewithregister" -- use motion to replace with clipboard
    use "tpope/vim-commentary" -- toggle comments with motions

    use "kana/vim-textobj-user" -- text object library base

    use "kana/vim-textobj-entire" -- text object e for entire file
    use "kana/vim-textobj-indent" -- text object i for indents
    use "sgur/vim-textobj-parameter" -- text object , for function parameters
end)
