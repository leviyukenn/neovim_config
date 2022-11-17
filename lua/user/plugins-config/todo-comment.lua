local status, todo = pcall(require, "todo-comments")
if not status then
	vim.notify("todo-comments not found")
	return
end

todo.setup({})

-- :TodoQuickFix
-- This uses the quickfix list to show all todos in your project.
--
-- :TodoLocList
-- This uses the location list to show all todos in your project.
--
-- :TodoTrouble
-- List all project todos in trouble
--
-- :TodoTelescope
-- Search through all project todos with Telescope
