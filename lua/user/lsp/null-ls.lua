local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local ts_code_actions = require("typescript.extensions.null-ls.code-actions")

null_ls.setup({
	debug = false,
	sources = {
		-- Formatting ---------------------
		--  brew install shfmt
		formatting.shfmt,
		-- StyLua
		formatting.stylua,
		-- frontend
		formatting.prettier.with({ -- 比默认少了 markdown
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
				"css",
				"scss",
				"less",
				"html",
				"json",
				"yaml",
				"graphql",
			},
			prefer_local = "node_modules/.bin",
		}),
		-- rustfmt
		-- rustup component add rustfmt
		formatting.rustfmt,
		-- Python
		-- pip install black
		-- asdf reshim python
		formatting.black.with({ extra_args = { "--fast" } }),
		-----------------------------------------------------
		-- Ruby
		-- gem install rubocop
		formatting.rubocop,
		-----------------------------------------------------
		-- formatting.fixjson,
		-- Diagnostics  ---------------------
		diagnostics.eslint.with({
			prefer_local = "node_modules/.bin",
		}),
		-- diagnostics.markdownlint,
		-- markdownlint-cli2
		-- diagnostics.markdownlint.with({
		--   prefer_local = "node_modules/.bin",
		--   command = "markdownlint-cli2",
		--   args = { "$FILENAME", "#node_modules" },
		-- }),
		--
		-- code actions ---------------------
		code_actions.gitsigns,
		code_actions.eslint.with({
			prefer_local = "node_modules/.bin",
		}),
		-- 添加typescript的code_actions
		-- Add Missing Imports
		-- Fix All
		-- Organize Imports
		-- Remove Unused
		ts_code_actions,
	},
	-- #{m}: message
	-- #{s}: source name (defaults to null-ls if not specified)
	-- #{c}: code (if available)
	diagnostics_format = "[#{s}] #{m}",
	-- 配置format on save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
