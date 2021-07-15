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

    -- start menu
    use "mhinz/vim-startify"

    -- git change markings
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require "pconf/gitsigns"
        end
    }

    -- nice git integration
    use "tpope/vim-fugitive"

    -- colour theme
    use { 
        "joshdick/onedark.vim",
        config = function()
            vim.g.onedark_terminal_italics = 1
            vim.g.onedark_hide_endofbuffer = 1
            vim.cmd "colorscheme onedark"
        end,
    }

    -- cool tabs
    use {
        "romgrk/barbar.nvim",
        config = function()
            require "pconf/barbar"
        end,
    }

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

    -- snippets
    use "hrsh7th/vim-vsnip"

    --
    -- Small qol plugins
    --

    use "christoomey/vim-sort-motion" -- sorts lines
    use "tpope/vim-repeat" -- able to repeat plugin maps
    use "tpope/vim-surround" -- easily edit (), "", etc
    use "vim-scripts/replacewithregister" -- use motion to replace with clipboard

    -- toggle comments
    use {
        "tpope/vim-commentary",
        config = function()
            require "pconf/commentary"
        end,
    }

    -- clipboard history
    use {
        "svermeulen/vim-yoink",
        config = function()
            require "pconf/yoink"
        end,
    }

    use "kana/vim-textobj-user" -- text object library base

    use "kana/vim-textobj-entire" -- text object e for entire file
    use "kana/vim-textobj-indent" -- text object i for indents
    use "sgur/vim-textobj-parameter" -- text object , for function parameters
end)

