#!/bin/zsh

##
# Commands, funtions and aliases
#
# Always set aliases _last,_ so they don't get used in function definitions.
#

# This lets you change to any dir without having to type `cd`, that is, by just
# typing its name. Be warned, though: This can misfire if there exists an alias,
# function, builtin or command with the same name.
# In general, I would recommend you use only the following without `cd`:
#   ..  to go one dir up
#   ~   to go to your home dir
#   ~-2 to go to the 2nd mostly recently visited dir
#   /   to go to the root dir
setopt AUTO_CD

# Type '-' to return to your previous dir.
alias -- -='cd -'
# '--' signifies the end of options. Otherwise, '-=...' would be interpreted as
# a flag.

# These aliases enable us to paste example code into the terminal without the
# shell complaining about the pasted prompt symbol.
alias %= \$=

# zmv lets you batch rename (or copy or link) files by using pattern matching.
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#index-zmv
autoload -Uz zmv
alias zmv='zmv -Mv'
alias zcp='zmv -Cv'
alias zln='zmv -Lv'

# autoload -Uz clipcopy
autoload -Uz tpwget
autoload -Uz tpclone
autoload -Uz tppush
autoload -Uz tpfetch

# Note that, unlike with Bash, you do not need to inform Zsh's completion system
# of your aliases. It will figure them out automatically.

# Set $PAGER if it hasn't been set yet. We need it below.
# `:` is a builtin command that does nothing. We use it here to stop Zsh from
# evaluating the value of our $expansion as a command.
[ -x /usr/bin/lesspipe ] && znap eval znap-lesspipe "$(SHELL=/bin/sh lesspipe)"
: ${PAGER:=less}

# Associate file name .extensions with programs to open them.
# This lets you open a file just by typing its name and pressing enter.
# Note that the dot is implicit; `gz` below stands for files ending in .gz
alias -s {css,gradle,html,js,json,md,patch,properties,txt,xml,yml}=$PAGER
alias -s gz='gzip -l'
alias -s {log,out}='tail -F'


# Use `< file` to quickly view the contents of any text file.
READNULLCMD=$PAGER  # Set the program to use for this.


# 列出文件和目录
alias ls='ls --color=auto'      # 启用彩色输出（Linux）
alias ll='ls -lh'               # 详细列表形式（带人类可读的文件大小）
alias la='ls -lAh'              # 显示所有文件（包括隐藏文件），不显示 "." 和 ".."
alias l='ls -CF'                # 紧凑形式，区分文件夹和文件
alias lt='ls -lt'               # 按时间排序的详细列表
alias lr='ls -lR'               # 递归列出所有子目录

alias mkdir='mkdir -pv'         # 自动创建父目录并显示创建路径

alias g='git'                   # 快捷调用 git
alias ga='git add'              # 添加文件到暂存区
alias gc='git commit'           # 提交代码
alias gcm='git commit -m'       # 快速提交代码（带消息）
alias gco='git checkout'        # 切换分支
alias gb='git branch'           # 查看分支
alias gl='git log'              # 查看提交历史
alias gp='git push'             # 推送代码
alias gpl='git pull'            # 拉取最新代码
alias gst='git status'          # 查看状态
alias gd='git diff'             # 查看改动
alias gf='git fetch'            # 拉取远程分支

# 更强大的 log 输出
alias glog='git log --oneline --graph --decorate --all'

alias h='history'               # 快速查看历史命令
alias j='jobs'                  # 查看后台任务
alias psg='ps aux | grep'       # 查找进程
alias du='du -h'                # 显示磁盘使用（人类可读）
alias df='df -h'                # 显示文件系统磁盘空间（人类可读）
alias free='free -m'            # 查看内存使用
alias top='htop'                # 使用更友好的 htop 代替 top

alias ip='ip -c'                # 显示彩色输出的 ip 命令
alias flushdns='sudo systemd-resolve --flush-caches' # 刷新 DNS 缓存

alias tarx='tar -xvf'            # 快速解压 tar 包
alias tarz='tar -cvzf'          # 创建 gzip 压缩包
alias untar='tar -xvf'           # 解压任意 tar 格式文件

alias zip='zip -r'              # 压缩为 zip 格式
alias unzip='unzip -d'          # 解压 zip 文件

alias 7z='7z x'                 # 解压 7z 文件
alias 7za='7z a'                # 压缩为 7z 格式

alias grep='grep --color=auto'  # 彩色高亮输出
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias find='find . -iname'      # 快速查找文件（忽略大小写）
alias locate='locate --regex'   # 使用正则表达式查找

# 快速搜索文本
alias rg='rg --hidden --follow' # 使用 ripgrep 递归搜索
alias ag='ag --hidden'          # 使用 silversearcher-ag 搜索
alias fd='fd --hidden'          # 使用 fd 搜索文件/目录

alias less='less -R'            # 支持 ANSI 转义序列

alias lg='lazygit'
alias ccp='clipcopy'

if command -v batcat > /dev/null; then
    alias bcat='batcat'
else
    alias bcat='bat'
fi

alias deg='double-entry-generator'
alias degtr='deg translate'
