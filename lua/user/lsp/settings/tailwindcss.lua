local common = require("user.lsp.lsp-common-config")

-- 启动lsp补全提示的taiwind写法的正则表达式
local classRegexTable = {}
classRegexTable[1] = { "accessibility\\(([^)]*)\\)", '"([^"]*)"' }
classRegexTable[2] = { "backgrounds\\(([^)]*)\\)", '"([^"]*)"' }
classRegexTable[3] = { "borders\\(([^)]*)\\)", '"([^"]*)"' }
classRegexTable[4] = { "tables\\(([^)]*)\\)", '"([^"]*)"' }
classRegexTable[5] = { "effects\\(([^)]*)\\)", '"([^"]*)"' }
classRegexTable[6] = { "transitionsAndAnimations\\(([^)]*)\\)", '"([^"]*)"' }
classRegexTable[7] = { "filters\\(([^)]*)\\)", '"([^"]*)"' }
classRegexTable[8] = { "flexBox\\(([^)]*)\\)", '"([^"]*)"' }
classRegexTable[9] = { "grid\\(([^)]*)\\)", '"([^"]*)"' }
classRegexTable[10] = { "grouping\\(([^)]*)\\)", '"([^"]*)"' }
classRegexTable[11] = { "spacing\\(([^)]*)\\)", '"([^"]*)"' }
classRegexTable[12] = { "interactivity\\(([^)]*)\\)", '"([^"]*)"' }
classRegexTable[13] = { "layout\\(([^)]*)\\)", '"([^"]*)"' }
classRegexTable[14] = { "sizing\\(([^)]*)\\)", '"([^"]*)"' }
classRegexTable[15] = { "svg\\(([^)]*)\\)", '"([^"]*)"' }
classRegexTable[16] = { "transforms\\(([^)]*)\\)", '"([^"]*)"' }
classRegexTable[17] = { "typography\\(([^)]*)\\)", '"([^"]*)"' }
classRegexTable[18] = { "classnames\\(([^)]*)\\)", '"([^"]*)"' }

local opts = {
	capabilities = common.capabilities,
	flags = common.flags,
	on_attach = function(client, bufnr)
		common.keyAttach(bufnr)
	end,
	settings = {
		tailwindCSS = {
			experimental = {
				classRegex = classRegexTable,
				-- classRegex = {
				-- 	"spacing\\(([^)]*)\\)",
				-- 	"'([^']*)'",
				-- },
			},
		},
	},
}

return {
	on_setup = function(server)
		server.setup(opts)
	end,
}
