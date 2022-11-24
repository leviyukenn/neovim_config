local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end

comment.setup({
	-- 导入ts_context_commentstring用于计算jsx/tsx的comment string
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
