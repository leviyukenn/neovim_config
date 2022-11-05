local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

-- 加载插件
-- telescope.load_extension('media_files')

local actions = require "telescope.actions"

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },

    -- 在keymaps.lua中统一定义keybinding
    mappings = require("user.keymaps").mapTelescope(actions),
  },
  -- pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  -- },
  extensions = {
--    media_files = {
        -- filetypes whitelist
        -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
--       filetypes = {"png", "webp", "jpg", "jpeg"},
--        find_cmd = "rg" -- find command (defaults to `fd`)
--        --     }
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  },
}
