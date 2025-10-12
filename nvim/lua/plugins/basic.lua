return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    opts = function()
      -- 创建切换 git 修改标记展示的快捷键
      Snacks.toggle({
        name = "Git Signs",
        get = function()
          return require("gitsigns.config").config.signcolumn
        end,
        set = function(state)
          require("gitsigns").toggle_signs(state)
        end,
      }):map("<leader>uG")
      -- 返回静态配置表格，这个表格会传递给 gitsigns.setup()
      return {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      }
    end,
  },
  {
    "nvim-mini/mini.pairs",
    event = "VeryLazy"
  },
  -- 高亮 Todo 等注释
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "FileType",
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>Tt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>TT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      -- 配置使用 snacks.picker 来搜索 todo 的快捷键
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
      { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc},
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },
  -- nvim 自带注释语法增强
  {"folke/ts-comments.nvim", event = "VeryLazy", opts = {}},
  {
    -- 保存会话，可以通过 <leader>ps 来恢复会话
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>ps", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>pS", function() require("persistence").select() end,desc = "Select Session" },
      { "<leader>pl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>pd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
  { "nvim-lua/plenary.nvim", lazy = true }
}
