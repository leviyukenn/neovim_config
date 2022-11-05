local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local lspkind_status_ok, lspkind = pcall(require, "lspkind")
if not lspkind_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

-- 补全列表中的一些图标
--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  -- keymaps.lua中统一管理shortcut
  mapping = require("user.keymaps").mapCmp(cmp, luasnip, check_backspace),

  -- 定义补全提示列表的样式
  --  formatting = {
  -- 补全提示列表中每一项的样式: "kind abbr menu"
  --   fields = { "kind", "abbr", "menu" },
  --   format = function(entry, vim_item)
  -- Kind icons
  --     vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
  -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
  --     vim_item.menu = ({
  --       nvim_lsp = "[LSP]",
  --       nvim_lua = "[NVIM_LUA]",
  --       luasnip = "[Snippet]",
  --       buffer = "[Buffer]",
  --       path = "[Path]",
  --     })[entry.source.name]
  --     return vim_item
  --   end,
  -- },
  -- 使用lspkind插件定义补全提示列表的样式
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      --mode = 'symbol', -- show only symbol annotations

      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        -- Source 显示提示来源
        vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
        return vim_item
      end
    })
  },


  -- 补全提示列表中显示的优先顺序 nvim_lsp > nvim_lua> luasnip > buffer > path
  -- 下载了新的source插件后，需要在此引入
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}
