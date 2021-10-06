-- automatically get packer (plugin manager)
local install_path = DATA_PATH .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path, "--depth=1" })
	vim.api.nvim_command("packadd packer.nvim")
end
local packer = require("packer")

packer.init({
	git = {
		cmd = "git",
		depth = 1,
	},
})

local use = packer.use
packer.reset()

-- check if binary/executable exist
function CheckExist(binary)
	local cmd = string.format("command -v %s > /dev/null && printf exist", binary)
	local output = io.popen(cmd):read("*a")
	return output == "exist"
end

use("wbthomason/packer.nvim") -- packer plugin stuff
use("nvim-lua/plenary.nvim") -- lua utils
use("kyazdani42/nvim-web-devicons") -- nice icons

-- colour scheme
use({
	"navarasu/onedark.nvim",
	config = function()
		require("pconf/other").colorscheme()
	end,
})

-- start menu
use({
	"glepnir/dashboard-nvim",
	config = function()
		require("pconf/dashboard")
	end,
})

-- git changes markings
use({
	"lewis6991/gitsigns.nvim",
	event = "BufRead",
	config = function()
		require("gitsigns").setup({ keymaps = {} })
	end,
})

-- nice git integration
use({
	"tpope/vim-fugitive",
	cmd = { "Git", "Gread" },
})

-- cool status line
use({
	-- "hoob3rt/lualine.nvim",
	"shadmansaleh/lualine.nvim",
	after = "nvim-lspconfig",
	config = function()
		require("pconf/lualine")
	end,
})

-- file explorer
use({
	"kyazdani42/nvim-tree.lua",
	cmd = "ToggleTree",
	config = function()
		require("pconf/tree")
	end,
})

-- fuzzy finding
use({
	"nvim-telescope/telescope.nvim",
	requires = "nvim-lua/popup.nvim",
	cmd = { "Telescope" },
	config = function()
		require("pconf/telescope")
	end,
})

-- cool tabs
use({
	"romgrk/barbar.nvim",
	event = "BufRead",
})

-- show keybinds
use({
	"folke/which-key.nvim",
	config = function()
		require("which-key").setup()
	end,
})

--
-- Language server
--

use({
	"neovim/nvim-lspconfig",
	requires = "williamboman/nvim-lsp-installer",
	config = function()
		require("pconf/lspconfig")
	end,
})

-- lsp linters and formatter
use({
	"jose-elias-alvarez/null-ls.nvim",
	after = "nvim-lspconfig",
	config = function()
		require("pconf/null-ls")
	end,
})

-- autocomplete
use({
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	config = function()
		require("pconf/cmp")
	end,
})

use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })
use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
use({ "hrsh7th/cmp-calc", after = "nvim-cmp" })

-- view parameters and signitures
use({
	"ray-x/lsp_signature.nvim",
	after = "nvim-cmp",
	config = function()
		require("lsp_signature").setup()
	end,
})

-- snippet support
use({
	"L3MON4D3/LuaSnip",
	config = function()
		require("pconf/luasnip")
	end,
})

-- cool snippets
use({
	"rafamadriz/friendly-snippets",
	after = "LuaSnip",
})

use({
	"windwp/nvim-autopairs",
	after = "nvim-cmp",
	config = function()
		require("pconf/other").autopairs()
	end,
})

-- nice syntax highlight
use({
	"nvim-treesitter/nvim-treesitter",
	requires = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		require("pconf/treesitter")
	end,
})

-- debugging
use({
	"mfussenegger/nvim-dap",
	requires = {
		"Pocco81/DAPInstall.nvim",
	},
	event = "BufRead",
	config = function()
		require("pconf/dap")
	end,
})

--
-- Small qol plugins
--

-- better terminal support
use({
	"akinsho/nvim-toggleterm.lua",
	cmd = { "ToggleTerm", "ToggleTermOpenAll" },
	config = function()
		require("toggleterm").setup()
	end,
})

-- highlight colours eg #1f4a90 rgb(255, 255, 0)
use({
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("pconf/other").colorizer()
	end,
})

-- indent indicators
use({
	"lukas-reineke/indent-blankline.nvim",
	event = "BufRead",
	config = function()
		require("pconf/other").blankline()
	end,
})

-- better project management
use({
	"ahmedkhalf/project.nvim",
	config = function()
		require("project_nvim").setup({})
	end,
})

use("christoomey/vim-sort-motion") -- sorts lines
use("tpope/vim-repeat") -- able to repeat plugin maps
use("tpope/vim-surround") -- easily edit and make (), "", etc
use("tpope/vim-commentary") -- toggle comments with motions
use("vim-scripts/replacewithregister") -- use motion to replace with clipboard
