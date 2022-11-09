local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

-- 显示错误和警告数量
local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  update_in_insert = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width
}

-- vim 的模式 Normal/Insert/Visual
local mode = {
  "mode",
  fmt = function(str)
    return "-- " .. str .. " --"
  end,
}

-- lsp server 加载需要时间，lsp_progress显示进度
local lsp_progress ={
  "lsp_progress",
  spinner_symbols = { " ", " ", " ", " ", " ", " " },
}

-- 显示改行码种类
local fileformat ={
  "fileformat",
  symbols = {
    unix = "LF",
    dos = "CRLF",
    mac = "CR",
  },
}

-- 文件种类
local filetype = {
  "filetype",
  icons_enabled = false,
  icon = nil,
}

-- git branch
local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

-- cursor location
local location = {
  "location",
  padding = 0,
}

-- cool function for progress
-- 光标所在位置在文件中的进度
local progress = function()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

-- 显示delete/backspace键一次往回退几个space
local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
  -- options 用于设置样式
  options = {
    icons_enabled = true,
    theme = "tokyonight",
    -- 组件分隔符
    component_separators = { left = "", right = "" },
    -- 分段分隔符
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { branch, diagnostics },
    lualine_b = { mode },
    lualine_c = {
      lsp_progress,
    },
    -- lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_x = { diff, spaces, "encoding",fileformat, filetype },
    lualine_y = { location },
    lualine_z = { progress },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  -- 用于设置lualine支持的扩展
  extensions = {},
})
