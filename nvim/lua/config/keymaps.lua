-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- local map = LazyVim.safe_keymap_set
local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

map("i", "jk", "<ESC>")

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- NOTE: 两次 esc 使终端从 insert 模式切换回 normal 模式
-- 在某些终端不一定生效
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- 将当前文件的 LSP diagnostic 加载到（Location List）中，并显示
map("n", "<leader>qf", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- 使用 <Meta> hjkl 来在窗口间移动
map("n", "<M-H>", "<C-w>H", { desc = "Go to Left Window", remap = true })
map("n", "<M-J>", "<C-w>J", { desc = "Go to Lower Window", remap = true })
map("n", "<M-K>", "<C-w>K", { desc = "Go to Upper Window", remap = true })
map("n", "<M-L>", "<C-w>L", { desc = "Go to Right Window", remap = true })

-- 使用 <Ctrl> hjkl 作为上下左右移动
map({ "n", "x", "i" }, "<C-h>", "<Left>")
map({ "n", "x", "i" }, "<C-j>", "<Down>")
map({ "n", "x", "i" }, "<C-k>", "<Up>")
map({ "n", "x", "i" }, "<C-l>", "<Right>")

