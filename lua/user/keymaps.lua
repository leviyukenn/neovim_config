local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal 
-- Better window navigation
-- 分屏快捷键
keymap("n", "<leader>v", ":vsp<CR>", opts)
keymap("n", "<leader>h", ":sp<CR>", opts)

-- 关闭当前屏
keymap("n", "<leader>c", "<C-w>c", opts)

-- 关闭其它屏
keymap("n", "<leader>o", "<C-w>o", opts)

-- Control + hjkl实现分屏跳转
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- Resize with arrows
-- 调节分屏大小
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- 翻页
-- keymap("n", "<C-j>", "4j", opts)
-- keymap("n", "<C-k>", "4k", opts)
keymap("n", "<C-d>", "9j", opts)
keymap("n", "<C-u>", "9k", opts)

-- 打开terminal
keymap("n", "<leader>t", ":sp | terminal<CR>", opts)
keymap("n", "<leader>tv", ":vsp | terminal<CR>", opts)

-- Increment/Decrement
keymap("n", "+", "<C-a>", opts)
keymap("n", "-", "<C-x>", opts)

-- 全选
keymap("n", "<C-a>", "gg<S-v>G", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jj", "<ESC>", opts)

-- Insert模式下进入句首句末
keymap("i", "<C-h>", "<ESC>I", opts)
keymap("i", "<C-l>", "<ESC>A", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
-- 上下移动选中代码块 
keymap("v", "J", ":m .+1<CR>==", opts)
keymap("v", "K", ":m .-2<CR>==", opts)

--粘贴后不复制被覆盖的内容
keymap("v", "p", '"_dP', opts)


-- Terminal --
-- Better terminal navigation
keymap("t", "<Esc>", "<C-\\><C-n>", term_opts)
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)


-- Treesitter
-- 全文缩进并跳回原来光标所在处
-- keymap("n", "<leader>f", "gg=G<C-o>", opts)
-- 折叠代码
keymap('n', 'zz', ':foldclose<CR>', opts)
-- 展开代码
keymap('n', 'Z', ':foldopen<CR>', opts)

-- 插件快捷键
local pluginKeys = {}
-- lsp 回调函数快捷键设置
pluginKeys.mapLSP = function(bufnr)

  local lspOpts = { noremap = true, silent = true }
  local lspKeymap = vim.api.nvim_buf_set_keymap

  -- 用lspsaga的UI代替原生nvim-lsp

  -- gl 弹出行内浮动窗口
  -- lspKeymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", lspOpts)
  lspKeymap(bufnr, "n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", lspOpts)
  -- 下一个diagnostic
  -- lspKeymap(bufnr, "n", "gj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", lspOpts)
  lspKeymap(bufnr, "n", "gj", "<cmd>Lspsaga diagnostic_jump_next<CR>", lspOpts)
  -- 上一个diagnostic
  -- lspKeymap(bufnr, "n", "gk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", lspOpts)
  lspKeymap(bufnr, "n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<CR>", lspOpts)
  -- K 悬停（弹出text document)显示提示
  -- lspKeymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", lspOpts)
  lspKeymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>", lspOpts)
  -- 查找引用, 和gd相对
  -- lspKeymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", lspOpts)
  lspKeymap(bufnr, "n", "gr", "<cmd>Lspsaga lsp_finder<CR>", lspOpts)
  -- 跳转变量定义
  -- lspKeymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", lspOpts)
  lspKeymap(bufnr, "n", "gd", "<cmd>Lspsaga peek_definition<CR>", lspOpts)

  -- 修改变量名
  -- lspKeymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", lspOpts)
  lspKeymap(bufnr, "n", "<leader>rn", "<cmd>Lspsaga rename<CR>", lspOpts)

  -- code action
  -- lspKeymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", lspOpts)
  lspKeymap(bufnr, "n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", lspOpts)

  -- 以下比较少用
  lspKeymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", lspOpts)
  lspKeymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", lspOpts)
  lspKeymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", lspOpts)
  lspKeymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", lspOpts)
  lspKeymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", lspOpts)
  lspKeymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", lspOpts)
  lspKeymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", lspOpts)
end

-- null_ls提供formatting
keymap("n", "<leader>f", ":lua vim.lsp.buf.format{ async = true }<CR>", opts)

-- cmp补全提示快捷键
pluginKeys.mapCmp = function(cmp, luasnip, check_backspace)

  return {
    -- 在补全提示列表里选择上一条
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    -- 在补全提示列表里选择下一条
    ["<C-j>"] = cmp.mapping.select_next_item(),
    -- 补全提示列表中的Docs中scroll
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    -- 显示补全提示列表
    ["<C-,>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    -- 关闭补全提示列表ke
    ["<C-.>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    -- 选中补全提示列表中的一项
    ["<CR>"] = cmp.mapping.confirm { select = true },

    -- 增强Tab功能，使之成为Super Tab
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
        "i",
        "s",
      }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
        "i",
        "s",
      }),
  }
end

-- Telescope快捷键
keymap("n", "<C-p>", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<C-f>", "<cmd>Telescope live_grep<cr>", opts)

pluginKeys.mapTelescope = function(actions)

  return {
    -- Insert模式下
    i = {
      -- 翻阅搜索历史
      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,

      -- 直接从Insert模式翻阅上/下一条
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,

      -- 关闭
      ["<C-c>"] = actions.close,

      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,

      ["<CR>"] = actions.select_default,
      ["<C-x>"] = actions.select_horizontal,
      ["<C-v>"] = actions.select_vertical,
      ["<C-t>"] = actions.select_tab,

      ["<C-u>"] = actions.preview_scrolling_up,
      ["<C-d>"] = actions.preview_scrolling_down,

      ["<PageUp>"] = actions.results_scrolling_up,
      ["<PageDown>"] = actions.results_scrolling_down,

      ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
      ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
      ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      ["<C-l>"] = actions.complete_tag,
      ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
    },

    -- Normal模式下
    n = {
      ["<esc>"] = actions.close,
      ["<CR>"] = actions.select_default,
      ["<C-x>"] = actions.select_horizontal,
      ["<C-v>"] = actions.select_vertical,
      ["<C-t>"] = actions.select_tab,

      ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
      ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
      ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

      ["j"] = actions.move_selection_next,
      ["k"] = actions.move_selection_previous,
      ["H"] = actions.move_to_top,
      ["M"] = actions.move_to_middle,
      ["L"] = actions.move_to_bottom,

      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,
      ["gg"] = actions.move_to_top,
      ["G"] = actions.move_to_bottom,

      ["<C-u>"] = actions.preview_scrolling_up,
      ["<C-d>"] = actions.preview_scrolling_down,

      ["<PageUp>"] = actions.results_scrolling_up,
      ["<PageDown>"] = actions.results_scrolling_down,

      ["?"] = actions.which_key,
    },
  }
end

-- gitsigns
pluginKeys.gitsigns_on_attach = function(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map("n", "<leader>gj", function()
    if vim.wo.diff then
      return "]c"
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return "<Ignore>"
  end, { expr = true })

  map("n", "<leader>gk", function()
    if vim.wo.diff then
      return "[c"
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return "<Ignore>"
  end, { expr = true })

  map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>")
  map("n", "<leader>gS", gs.stage_buffer)
  map("n", "<leader>gu", gs.undo_stage_hunk)
  map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
  map("n", "<leader>gR", gs.reset_buffer)
  map("n", "<leader>gp", gs.preview_hunk)
  map("n", "<leader>gb", function()
    gs.blame_line({ full = true })
  end)
  map("n", "<leader>gd", gs.diffthis)
  map("n", "<leader>gD", function()
    gs.diffthis("~")
  end)
  -- toggle
  map("n", "<leader>gtd", gs.toggle_deleted)
  map("n", "<leader>gtb", gs.toggle_current_line_blame)
  -- Text object
  map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")
end

-- nvim-tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
-- 列表快捷键
pluginKeys.nvimTreeList = { 
  -- 打开文件或文件夹
  { key = { "O", "<2-LeftMouse>" }, action = "system_open" },
  { key = { "o","<CR>"}, action = "edit" },
  -- v分屏打开文件
  { key = "v", action = "vsplit" },
  -- h分屏打开文件
  { key = "h", action = "split" },
  -- Ignore (node_modules)
  { key = "i", action = "toggle_ignored" },
  -- Hide (dotfiles)
  { key = ".", action = "toggle_dotfiles" },
  { key = "R", action = "refresh" },
  -- 文件操作
  { key = "a", action = "create" },
  { key = "d", action = "remove" },
  { key = "r", action = "rename" },
  { key = "x", action = "cut" },
  { key = "c", action = "copy" },
  { key = "p", action = "paste" },
  { key = "y", action = "copy_name" },
  { key = "Y", action = "copy_path" },
  { key = "gy", action = "copy_absolute_path" },
  { key = "I", action = "toggle_file_info" },
  { key = "n", action = "tabnew" },
  -- 进入下一级
  { key = { "]" }, action = "cd" },
  -- 进入上一级
  { key = { "[" }, action = "dir_up" },
}

-- "moll/vim-bbye" 关闭当前 buffer
keymap("n", "<leader>bc", ":Bdelete!<CR>", opts)
keymap("n", "<C-w>", ":Bdelete!<CR>", opts)
-- 关闭左/右侧标签页
keymap("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opts)
keymap("n", "<leader>bl", ":BufferLineCloseRight<CR>", opts)
-- 关闭其他标签页
keymap("n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>", opts)
-- 关闭选中标签页
keymap("n", "<leader>bp", ":BufferLinePickClose<CR>", opts)
-- 关闭neovim tab（bufferline右边的数字)
keymap("n", "<leader>tc", ":tabclose<CR>", opts)

return pluginKeys
