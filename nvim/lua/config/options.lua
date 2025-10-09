-- vim.opt 默认表示 global
-- vim.opt.local 表示 buffer 局部
-- vim.opt.winlocal 表示 window 局部
local opt = vim.opt

-- 是否使用 nerd font，许多插件会读取这个变量
-- 测试为 false 的效果
vim.g.have_nerd_font = false

-- 显示行号并使用相对行号
opt.number = true
opt.relativenumber = true

-- 不显示当前模式，statusline 中会显示
opt.showmode = false

-- 使 neovim 的剪贴板与 系统保持一致
-- schedule 函数表示让 vim 先启动，再执行内部操作
-- 防止影响启动速度
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

-- 智能缩进，启用 wrap 后，软换行保持相同的缩进
opt.breakindent = true

-- 保存 undo 历史
opt.undofile = true

-- 搜索忽略大小写，当搜索内容包含大写时不忽略
vim.o.ignorecase = true
vim.o.smartcase = true

-- 始终显示最左侧的标志列，例如断点、git 更改标记等
vim.o.signcolumn = "yes"

-- 设置后台事件如 LSP 诊断的触发时长
-- 表示 vim 停止输入后，将 buffer 更改写入磁盘的等待时间
vim.o.updatetime = 500

-- 键盘映射的等待时间，保持默认的 1000ms
vim.o.timeoutlen = 1000

-- 默认为向右与向下分屏
vim.o.splitright = true
vim.o.splitbelow = true

-- 缩进
opt.tabstop = 4
opt.shiftwidth = 4
opt.fileformat = "unix"

function my_paste(reg)
  return function(lines)
    --[ 返回 “” 寄存器的内容，用来作为 p 操作符的粘贴物 ]
    local content = vim.fn.getreg('"')
    return vim.split(content, "\n")
  end
end

if vim.env.SSH_TTY then
  --[ 当前环境为本地环境，也包括 wsl ]
  opt.clipboard:append("unnamedplus")
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      --[ 小括号里面的内容可能是毫无意义的，但是保持原样可能看起来更好一点 ]
      ["+"] = my_paste("+"),
      ["*"] = my_paste("*"),
    },
  }
end
opt.spelllang = { "en", "cjk" }
