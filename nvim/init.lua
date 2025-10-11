-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.options")
if vim.g.vscode then
  require("vsc.config.keymaps")
  require("lazy").setup("plugins.simple")
  require("lazy").setup("plugins.treesitter")
else
  require("lazy").setup("plugins")
end
