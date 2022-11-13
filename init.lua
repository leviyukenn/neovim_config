-- some nvim-tree settings
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

------------------------------------------------

-- 导入各种配置文件
require("user.options")
require("user.keymaps")
require("user.plugins")
require("user.colorscheme")
require("user.cmp")
-- 导入lsp文件夹中的配置入口文件init.lua
require("user.lsp")
require("user.telescope")
require("user.treesitter")

require("user.plugins-config.indent-blankline")
require("user.plugins-config.autopairs")
require("user.plugins-config.autotags")
require("user.plugins-config.comment")
require("user.plugins-config.gitsigns")
require("user.plugins-config.nvim-tree")
require("user.plugins-config.bufferline")
require("user.plugins-config.lualine")
require("user.plugins-config.typescript")
require("user.plugins-config.surround")
