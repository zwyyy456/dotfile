return {
  { -- Useful plugin to show you pending keybinds.
      'folke/which-key.nvim',
      dependencies = { 'nvim-mini/mini.icons' },
      event = 'VeryLazy', -- Sets the loading event to 'VimEnter'
      opts = {
        -- delay between pressing a key and opening which-key (milliseconds)
        -- this setting is independent of vim.o.timeoutlen
        preset = "helix",
        delay = 250,
        icons = {
          -- set icon mappings to true if you have a Nerd Font
          mappings = vim.g.have_nerd_font,
          -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
          -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
          keys = vim.g.have_nerd_font and {} or {
            Up = '<Up> ',
            Down = '<Down> ',
            Left = '<Left> ',
            Right = '<Right> ',
            C = '<C-…> ',
            M = '<M-…> ',
            D = '<D-…> ',
            S = '<S-…> ',
            CR = '<CR> ',
            Esc = '<Esc> ',
            ScrollWheelDown = '<ScrollWheelDown> ',
            ScrollWheelUp = '<ScrollWheelUp> ',
            NL = '<NL> ',
            BS = '<BS> ',
            Space = '<Space> ',
            Tab = '<Tab> ',
            F1 = '<F1>',
            F2 = '<F2>',
            F3 = '<F3>',
            F4 = '<F4>',
            F5 = '<F5>',
            F6 = '<F6>',
            F7 = '<F7>',
            F8 = '<F8>',
            F9 = '<F9>',
            F10 = '<F10>',
            F11 = '<F11>',
            F12 = '<F12>',
          },
        },
        -- Document existing key chains
        spec = {
          { 'g', group = '[G]oto'},
          { '<leader>s', group = '[S]earch' },
          { '<leader>b', group = '[B]uffer' },
          { '<leader>g', group = '[G]', mode = { 'n', 'v' }},
          { '<leader>G', group = '[G]it'},
          { '<leader>T', group = '[T]rouble UI View'},
          { '<leader>t', group = '[T]oggle view'},
          { '<leader>u', group = '[U]nset'},
          { '<leader>f', group = '[F]iles'},
          { '<leader>p', group = '[P]ersistence Sessions'},
          { '<leader>q', group = '[Q]uickfix'},
          { '<leader>r', group = '[R]ename'},
          { '<leader>Gh', group = 'Git [H]unks'},
          { "z", group = "fold" },
        }
      },
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
        },
      },
    },
    keys = {
      -- <leader>Tx: 切换（toggle）trouble 窗口，显示整个项目的诊断信息（错误、警告等）
      { "<leader>Tx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      -- <leader>TX: 切换 trouble 窗口，但只显示当前文件的诊断信息（通过 filter.buf=0 实现）。
      { "<leader>TX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      -- <leader>Ts: 切换 trouble 窗口，显示当前文件的代码结构/符号列表（Symbols），如函数、变量、类等。
      { "<leader>Ts", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      -- <leader>TS: 切换 trouble 窗口，显示 LSP 的结果，比如您执行“查找所有引用”或“跳转到定义”后的列表。
      { "<leader>TS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
      -- <leader>TL: 用 trouble 的漂亮界面来显示位置列表 (Location List) 的内容。
      { "<leader>TL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      -- <leader>TQ: 用 trouble 的漂亮界面来显示 quickfix 列表 (Quickfix List) 的内容。
      { "<leader>TQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      -- 如果 trouble 窗口是打开的：[q 会跳转到 trouble 列表中的上一个项目，]q 会跳转到下一个项目
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  }
}