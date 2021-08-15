-- automatically get packer (plugin manager)
local install_path = DATA_PATH.."/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.api.nvim_command("packadd packer.nvim")
end

local packer = require("packer")

packer.init({
    git = {
        cmd = "git",
        depth = 1,
    }
})

local use = packer.use
packer.reset()

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
    event = "VimEnter",
    config = function()
        require "pconf/tree"
    end,
}

use {
    "mhartington/formatter.nvim",
    config = function()
        require("pconf/formatter")
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

-- cool tabs
use {
    "romgrk/barbar.nvim",
    config = function()
        require "pconf/barbar"
    end,
}

-- emmet integration
use {
    "mattn/emmet-vim",
    config = function()
        vim.g.user_emmet_mode = "vn"
        vim.g.user_emmet_leader_key = ","
    end,
}

--
-- Language server
--

use "neovim/nvim-lspconfig"

-- easilly install language servers
use {
    "williamboman/nvim-lsp-installer",
    config = function()
        require "pconf/lsp-installer"
    end,
}

-- view parameters and signitures
use {
    "ray-x/lsp_signature.nvim",
    after = "nvim-lsp-installer",
    config = function()
        require("lsp_signature").setup()
    end
}

-- autocomplete
use {
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    config = function()
        require "pconf/compe"
    end,
}

use {
    "windwp/nvim-autopairs",
    after = "nvim-compe",
    config = function()
        require("pconf/other").autopairs()
    end,
}

-- snippet support
use {
    "hrsh7th/vim-vsnip",
    after = "nvim-compe",
}

-- nice syntax highlight
use {
    "nvim-treesitter/nvim-treesitter",
    requires = {
        { "p00f/nvim-ts-rainbow" },
        { "JoosepAlviste/nvim-ts-context-commentstring" },
    },
    config = function()
        require "pconf/treesitter"
    end,
}

--
-- Small qol plugins
--

-- better terminal support
use {
    "akinsho/nvim-toggleterm.lua",
    cmd = { "ToggleTerm", "TermExec" },
    config = function()
        require("toggleterm").setup()
    end,
}

-- clipboard history
use {
    "svermeulen/vim-yoink",
    config = function()
        require "pconf/yoink"
    end,
}

-- highlight colours eg #1f4a90 rgb(255, 255, 0)
use {
    "norcalli/nvim-colorizer.lua",
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

use "christoomey/vim-sort-motion" -- sorts lines
use "tpope/vim-repeat" -- able to repeat plugin maps
use "tpope/vim-surround" -- easily edit (), "", etc
use "tpope/vim-commentary" -- toggle comments with motions
use "vim-scripts/replacewithregister" -- use motion to replace with clipboard

use "kana/vim-textobj-user" -- text object library base

use "kana/vim-textobj-entire" -- text object e for entire file
use "kana/vim-textobj-indent" -- text object i for indents
use "sgur/vim-textobj-parameter" -- text object , for function parameters
