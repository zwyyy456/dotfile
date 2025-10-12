-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.options")
require("config.keymaps")
if vim.g.vscode then
  require("vsc.config.keymaps")
  require("lazy").setup({
    require("plugins.simple"),
    require("plugins.treesitter")
  })
else
  require("lazy").setup("plugins")
end
