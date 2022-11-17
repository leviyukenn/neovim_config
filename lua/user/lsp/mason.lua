-- 要下载的lsp servers
--
---- mason-lspconfig uses the `lspconfig` server names in the APIs it exposes - not `mason.nvim` package names
-- mason-lspconfig用的是lspconfig里的server名，而不是mason.nvim中的package名
-- 对应关系见以下链接
-- 比如lspconfig中的server名为cssls,而mason.nvim中的package名为css-lsp
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
local servers = {
	"sumneko_lua",
	"cssls",
	"html",
	"tsserver",
	-- "pyright",
	-- "bashls",
	"jsonls",
	-- "yamlls",
	"emmet_ls",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	-- 确保下载servers中定义的server对应的mason package
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}
for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.lsp-common-config").on_attach,
		capabilities = require("user.lsp.lsp-common-config").capabilities,
	}

	server = vim.split(server, "@")[1]

	local _, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if conf_opts ~= nil and type(conf_opts) == "table" then
		-- 自定义初始化配置文件必须实现on_setup 方法
		conf_opts.on_setup(lspconfig[server])
	else
		-- 使用默认参数
		lspconfig[server].setup({ opts })
	end
end

-- for _, server in pairs(servers) do
-- 	opts = {
-- 		on_attach = require("lsp.handlers").on_attach,
-- 		capabilities = require("lsp.handlers").capabilities,
-- 	}
--
-- 	server = vim.split(server, "@")[1]
--
-- 	local require_ok, conf_opts = pcall(require, "lsp.settings." .. server)
-- 	if require_ok then
-- 		opts = vim.tbl_deep_extend("force", conf_opts, opts)
-- 	end
--
-- 	lspconfig[server].setup(opts)
-- end
