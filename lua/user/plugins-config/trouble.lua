local status, trouble = pcall(require, "trouble")
if not status then
	vim.notify("trouble not found")
	return
end

trouble.setup({})

-- Commands
-- Trouble comes with the following commands:
--
-- Trouble [mode]: open the list
-- TroubleClose [mode]: close the list
-- TroubleToggle [mode]: toggle the list
-- TroubleRefresh: manually refresh the active list
-- Modes:
--
-- document_diagnostics: document diagnostics from the builtin LSP client
-- workspace_diagnostics: workspace diagnostics from the builtin LSP client
-- lsp_references: references of the word under the cursor from the builtin LSP client
-- lsp_definitions: definitions of the word under the cursor from the builtin LSP client
-- lsp_type_definitions: type definitions of the word under the cursor from the builtin LSP client
-- quickfix: quickfix items
-- loclist: items from the window's location list
