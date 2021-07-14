-- automatically get packer (plugin manager)
local install_path = DATA_PATH.."/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.api.nvim_command("packadd packer.nvim")
end

return require("packer").startup(function()
    -- packer plugin stuff
    use "wbthomason/packer.nvim" 

    -- nice icons
    use "kyazdani42/nvim-web-devicons" 

    -- use {
    --     "lewis6991/gitsigns.nvim",
    --     requires = {"nvim-lua/plenary.nvim"},
    --     config = function()
    --         require("gitsigns").setup()
    --     end
    -- }

    -- start menu
    use "mhinz/vim-startify" 

    -- colour theme
    use { 
        "joshdick/onedark.vim",
        config = function()
            vim.g.onedark_terminal_italics = 1
            vim.g.onedark_hide_endofbuffer = 1
            vim.cmd "colorscheme onedark"
        end
    }

    -- cool status tabs
    use { 
        "romgrk/barbar.nvim",
        config = function()
            require "pconf/barbar"
        end
    }

    -- small qol plugins
    use "christoomey/vim-sort-motion" -- sorts lines
    use "tpope/vim-commentary" -- toggle comments
    use "tpope/vim-repeat" -- able to repeat plugin maps
    use "tpope/vim-surround" -- easily edit (), "", etc
    use "vim-scripts/replacewithregister" -- use motion to replace with clipboard

    -- clipboard history
    use { 
        "svermeulen/vim-yoink",
        config = function()
            require "pconf/yoink"
        end
    } 

    use "kana/vim-textobj-user" -- text object library base

    use "kana/vim-textobj-entire" -- text object e for entire file
    use "kana/vim-textobj-indent" -- text object i for indents
    use "sgur/vim-textobj-parameter" -- text object , for function parameters
end)

