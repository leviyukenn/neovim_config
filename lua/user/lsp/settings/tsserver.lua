local status, typescript = pcall(require, "typescript")
if not status then
	vim.notify("typescript plugin not found")
	return
end

local common = require("user.lsp.lsp-common-config")

local opts = {
	capabilities = common.capabilities,
	flags = common.flags,
	on_attach = function(client, bufnr)
		-- common.disableFormat(client)
		-- 绑定lsp快捷键
		common.keyAttach(bufnr)
		local function buf_set_keymap(mode, lhs, rhs)
			vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr })
		end

		-- 绑定typescript快捷键
		require("user.keymaps").mapTsLSP(buf_set_keymap)
	end,
}
return {
	on_setup = function(_)
		typescript.setup({
			disable_commands = false, -- prevent the plugin from creating Vim commands
			debug = false, -- enable debug logging for commands
			go_to_source_definition = {
				fallback = true, -- fall back to standard LSP definition on failure
			},
			server = opts,
		})
	end,
}
