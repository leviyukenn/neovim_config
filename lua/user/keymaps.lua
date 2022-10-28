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
keymap("n", "<C-j>", "4j", opts)
keymap("n", "<C-k>", "4k", opts)
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
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
