-- 将 gd 映射到 VS Code 的 "Go to Definition" 命令
local map = vim.api.nvim_set_keymap
map("n", "K", '<Cmd>lua require("vscode").action("editor.action.showHover")<CR>', { noremap = true, silent = true })

map(
  "n",
  "gD",
  '<Cmd>lua require("vscode").action("editor.action.peekDefinition")<CR>',
  { noremap = true, silent = true }
)

map(
  "n",
  "gn",
  '<Cmd>lua require("vscode").action("editor.action.triggerParameterHints")<CR>',
  { noremap = true, silent = true }
)

map(
  "n",
  "gs",
  '<Cmd>lua require("vscode").action("workbench.action.gotoSymbol")<CR>',
  { noremap = true, silent = true }
)
map(
  "n",
  "gS",
  '<Cmd>lua require("vscode").action("workbench.action.showAllSymbols")<CR>',
  { noremap = true, silent = true }
)
map(
  "n",
  "gr",
  '<Cmd>lua require("vscode").action("editor.action.goToReferences")<CR>',
  { noremap = true, silent = true }
)

map(
  "n",
  "gR",
  '<Cmd>lua require("vscode").action("references-view.findReferences")<CR>',
  { noremap = true, silent = true }
)

map(
  "n",
  "gi",
  '<Cmd>lua require("vscode").action("editor.action.goToImplementation")<CR>',
  { noremap = true, silent = true }
)

map(
  "n",
  "gI",
  '<Cmd>lua require("vscode").action("editor.action.peekImplementation")<CR>',
  { noremap = true, silent = true }
)

map("n", "rn", '<Cmd>lua require("vscode").action("editor.action.rename")<CR>', { noremap = true, silent = true })

map("n", "[g", '<Cmd>lua require("vscode").action("editor.action.marker.prev")<CR>', { noremap = true, silent = true })

map("n", "g[", '<Cmd>lua require("vscode").action("editor.action.marker.next")<CR>', { noremap = true, silent = true })
map(
  "n",
  "gH",
  '<Cmd>lua require("vscode").action(""references-view.showCallHierarchy"")<CR>',
  { noremap = true, silent = true }
)
