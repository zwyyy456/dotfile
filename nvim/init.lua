-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.g.vscode then
  require("vsc.config.keymaps")
end
require("config.lazy")
