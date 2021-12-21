local function plugin_setup(use)
	use("wbthomason/packer.nvim") -- packer plugin stuff
	use("kyazdani42/nvim-web-devicons") -- nice icons
	use("nvim-lua/plenary.nvim") -- lua utils
	use("nvim-lua/popup.nvim") -- popup lib

	-- colour scheme
	use({
		"navarasu/onedark.nvim",
		config = function()
			require("configs/other").colorscheme()
		end,
	})

	-- start menu
	use({
		"glepnir/dashboard-nvim",
		cond = "not MINIMAL",
		config = function()
			require("configs/dashboard")
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
		"nvim-lualine/lualine.nvim",
		event = "BufWinEnter",
		config = function()
			require("configs/lualine")
		end,
	})

	-- file explorer
	use({
		"kyazdani42/nvim-tree.lua",
		cmd = "ToggleTree",
		config = function()
			require("configs/tree")
		end,
	})

	-- fuzzy finding
	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-telescope/telescope-fzy-native.nvim" },
		cond = "not MINIMAL",
		cmd = { "Telescope" },
		config = function()
			require("configs/telescope")
		end,
	})

	-- cool tabs
	use({ "romgrk/barbar.nvim", cond = "not MINIMAL" })

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
		requires = { "nvim-lua/lsp-status.nvim", "williamboman/nvim-lsp-installer" },
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
		event = "InsertEnter",
		config = function()
			require("configs/cmp")
		end,
	})

	use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })

	-- view parameters and signitures
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
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("configs/treesitter")
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
		cond = "not MINIMAL",
		config = function()
			require("project_nvim").setup({})
		end,
	})

	use("christoomey/vim-sort-motion") -- sorts lines
	use("tpope/vim-repeat") -- able to repeat plugin maps
	use("tpope/vim-surround") -- easily edit and make (), "", etc
	use("tpope/vim-commentary") -- toggle comments with motions
	use("vim-scripts/replacewithregister") -- use motion to replace with clipboard
end

-- automatically get packer (plugin manager)
local install_path = DATA_PATH .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	packer_bootstrap = vim.fn.system({
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
		if packer_bootstrap then
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
