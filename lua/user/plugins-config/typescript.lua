require("typescript").setup({
	disable_commands = false, -- prevent the plugin from creating Vim commands
	debug = false, -- enable debug logging for commands
	go_to_source_definition = {
		fallback = true, -- fall back to standard LSP definition on failure
	},
	server = { -- pass options to lspconfig's setup method
		-- on_attach = ...,
		-- -- 绑定增强插件快捷键
		on_attach = function(client, bufnr)
			require("user.keymaps").mapTsLSP(bufnr)
		end,
	},
})
