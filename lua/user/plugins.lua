local fn = vim.fn

-- Automatically install packer
-- fn.stdpath "data"为标准数据目录, 可以通过:echo stdpath("data")查看,默认为~/.loacl/share/nvim
--
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("folke/tokyonight.nvim") -- tokyonight colorscheme

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin

	-- cmp补全的source插件
	-- 可以自由添加需要的source
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- lua snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("jose-elias-alvarez/null-ls.nvim") -- 可以作为一个通用 Language Server 来给编辑器注入代码补全，格式化，提示，code actions 等新功能

	-- 下载和管理LSP servers
	use("williamboman/mason.nvim") -- simple to use language server installer
	use("williamboman/mason-lspconfig.nvim") -- simple to use language server installer

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	-- projects(作为Telescope的插件)
	use("ahmedkhalf/project.nvim")

	-- treesitter （新增）
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	-- treesitter插件 rainbow
	use("p00f/nvim-ts-rainbow")

	-- lsp cmp补全提示列表UI增强
	use("onsails/lspkind-nvim")

	-- indent blank line
	use("lukas-reineke/indent-blankline.nvim")

	-- lspsaga lsp诊断UI增强
	use("glepnir/lspsaga.nvim")

	-- autopairs
	use("windwp/nvim-autopairs")

	-- auto tags
	use("windwp/nvim-ts-autotag")

	-- comments
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("JoosepAlviste/nvim-ts-context-commentstring") -- comment for jsx

	-- nvim-tree
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
	})

	-- Git signs
	use("lewis6991/gitsigns.nvim")

	-- bufferline
	use({
		"akinsho/bufferline.nvim",
		requires = { "moll/vim-bbye", "nvim-tree/nvim-web-devicons" },
	})

	-- lualine
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	use("arkav/lualine-lsp-progress")

	--typescript utility
	use("jose-elias-alvarez/typescript.nvim")

	-- surround
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
	})

	-- dashboard
	use("glepnir/dashboard-nvim")

	-- fidget
	use("j-hui/fidget.nvim")

	-- toggleterm
	use({ "akinsho/toggleterm.nvim" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
