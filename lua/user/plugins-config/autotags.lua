-- Setup nvim-cmp.
local status_ok, auto_tags = pcall(require,'nvim-ts-autotag')
if not status_ok then
  return
end

auto_tags.setup()
