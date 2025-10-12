local BasicFunc = require("utils.func.basic")
return {
  {
    "folke/snacks.nvim",
    priority = 100,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      {
        "<leader>n",
        function()
          if Snacks.config.picker and Snacks.config.picker.enabled then
            Snacks.picker.notifications()
          else
            Snacks.notifier.show_history()
          end
        end,
        desc = "Notification History",
      },
      {
        "<leader>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
      {
        "<leader>tt",
        function()
          Snacks.explorer({ cwd = BasicFunc.get() })
        end,
        desc = "[T]oggle File [T]ree Explorer(root)",
      },
      -- 配置使用 Snacks 来模糊搜索的快捷键
      {
        "<leader>fr",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>fC",
        function()
          Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Find Config File",
      },
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
      {
        "<leader>fP",
        function()
          Snacks.picker.projects()
        end,
        desc = "Projects",
      },
      {
        "<leader>fM",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent",
      },
      {
        "<leader>fy",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },

      -- quickfix list
      {
        "<leader>fq",
        function()
          Snacks.picker.qflist()
        end,
        desc = "Quickfix",
      },
      -- git
      {
        "<leader>fG",
        function()
          Snacks.picker.git_files()
        end,
        desc = "Find Git Files",
      },
      {
        "<leader>Gb",
        function()
          Snacks.picker.git_branches()
        end,
        desc = "Git Branches",
      },
      {
        "<leader>Gl",
        function()
          Snacks.picker.git_log()
        end,
        desc = "Git Log",
      },
      {
        "<leader>GL",
        function()
          Snacks.picker.git_log_line()
        end,
        desc = "Git Log Line",
      },
      {
        "<leader>Gs",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Git Status",
      },
      {
        "<leader>GS",
        function()
          Snacks.picker.git_stash()
        end,
        desc = "Git Stash",
      },
      {
        "<leader>Gd",
        function()
          Snacks.picker.git_diff()
        end,
        desc = "Git Diff (Hunks)",
      },
      {
        "<leader>Gf",
        function()
          Snacks.picker.git_log_file()
        end,
        desc = "Git Log File",
      },
      {
        "<leader>Gg",
        function()
          Snacks.lazygit({ cwd = BasicFunc.git() })
        end,
        { desc = "Lazygit (Root Dir)" },
      },
      {
        "<leader>GG",
        function()
          Snacks.lazygit()
        end,
        { desc = "Lazygit (cwd)" },
      },

      -- lsp
      { "<leader>fn",
        function()
          Snacks.picker.lsp_symbols({ filter = { default = { "Function", "Method" } } })
        end, -- vim 中这个快捷键只是用来查找 Vim 自身函数
        desc = "Snacks.picker: Document Functions & Methods"
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = "Workspace Symbols, like Gtags",
      },
    },
  },
}

