local status, todo = pcall(require, "todo-comments")
if not status then
	vim.notify("todo-comments not found")
	return
end

todo.setup({})
