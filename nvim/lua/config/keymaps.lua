-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

map("i", "jk", "<ESC>")

-- 使用 <Meta> hjkl 来在窗口间移动
map("n", "<M-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<M-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<M-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<M-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- 使用 <Ctrl> hjkl 作为上下左右移动
map({ "n", "x", "i" }, "<C-h>", "<Left>")
map({ "n", "x", "i" }, "<C-j>", "<Down>")
map({ "n", "x", "i" }, "<C-k>", "<Up>")
map({ "n", "x", "i" }, "<C-l>", "<Right>")

-- fzf-lua 通过 lsp 搜索当前文档的所有符号
map("n", "<leader>fn", function()
  Snacks.picker.lsp_symbols()
end, { desc = "Snacks.picker: Document Symbols", silent = true })

-- 格式化代码
map({ "n", "v" }, "<leader>fm", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })
