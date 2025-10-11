local treesitter_have = require("utils.func.treesitter").have

return {
  { -- Highlight, edit, and navigate code
    -- 基于语法树解析的高亮
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    version = '*',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    event = { "FileType", "VeryLazy" },
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" }, -- 运行以上命令时立即加载插件
    opts = {
      ensure_installed = {
        'bash', 'beancount', 'c', 'cmake', 'cpp', 'css', 'csv', 'dart', 'diff', 'dockerfile', 
        'gitcommit', 'go', 'html', 'javascript', 'json', 'lua', 'luadoc', 'markdown', 'markdown_inline', 
        'python', 'query', 'rust', 'sql', 'toml', 'typescript', 'vim', 'vimdoc', 'yaml', 'xml'
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  {
    -- 将 textobject 扩展到函数、类
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    opts = {
      move = {
        enable = true,
        set_jumps = true, -- 使 ]f 等跳转可以通过 <c-o>、<c-i> 来切换
        -- 创建跳转到下一个函数起始位置的快捷键 ]f，下一个类的快捷键 ]c 等
        -- ]F 表示跳转到下一个函数的结束位置
        keys = {
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
      },
    },
    config = function(_, opts)
      local TS = require("nvim-treesitter-textobjects")
      if not TS.setup then
        vim.notify("ERROR: Please use :Lazy and update nvim-treesitter", vim.log.levels.ERROR, { title = "Treesitter Config Error" })
        return
      end
      TS.setup(opts)

      -- 通过 autocmd，在 filetype 确定后设置快捷键映射和用于 which-key 的描述
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("lazyvim_treesitter_textobjects", { clear = true }),
        callback = function(ev)
          if not (vim.tbl_get(opts, "move", "enable") and treesitter_have(ev.match, "textobjects")) then
            return
          end
          ---@type table<string, table<string, string>>
          local moves = vim.tbl_get(opts, "move", "keys") or {}

          for method, keymaps in pairs(moves) do
            for key, query in pairs(keymaps) do
              local desc = query:gsub("@", ""):gsub("%..*", "")
              desc = desc:sub(1, 1):upper() .. desc:sub(2)
              desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
              desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")
              if not (vim.wo.diff and key:find("[cC]")) then
                vim.keymap.set({ "n", "x", "o" }, key, function()
                  require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
                end, {
                  buffer = ev.buf,
                  desc = desc,
                  silent = true,
                })
              end
            end
          end
        end,
      })
    end,
  },
  {
    -- 输入 <tag> 后自动补全对应的 </tag>
    "windwp/nvim-ts-autotag",
    event = "FileType",
    opts = {},
  }
}