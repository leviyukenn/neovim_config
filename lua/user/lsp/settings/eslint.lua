local common = require("user.lsp.lsp-common-config")

local opts = {
	capabilities = common.capabilities,
	flags = common.flags,
	on_attach = function(client, bufnr)
		-- common.disableFormat(client)
		-- 绑定lsp快捷键
		common.keyAttach(bufnr)
	end,
	settings = {
		workingDirectory = {
			mode = "auto",
		},
	},
}
return {
	on_setup = function(server)
		server.setup(opts)
	end,
}
