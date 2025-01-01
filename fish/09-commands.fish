#!/usr/bin/env fish
alias ll='ls -lh' # 详细列表形式（带人类可读的文件大小）
alias la='ls -lAh' # 显示所有文件（包括隐藏文件），不显示 "." 和 ".."
alias l='ls -CF' # 紧凑形式，区分文件夹和文件
alias lt='ls -lt' # 按时间排序的详细列表
alias lr='ls -lR' # 递归列出所有子目录

alias mkdir='mkdir -pv' # 自动创建父目录并显示创建路径

alias g='git' # 快捷调用 git
alias ga='git add' # 添加文件到暂存区
alias gc='git commit' # 提交代码
alias gcm='git commit -m' # 快速提交代码（带消息）
alias gco='git checkout' # 切换分支
alias gb='git branch' # 查看分支
alias gl='git log' # 查看提交历史
alias gp='git push' # 推送代码
alias gpl='git pull' # 拉取最新代码
alias gst='git status' # 查看状态
alias gd='git diff' # 查看改动
alias gf='git fetch' # 拉取远程分支

# 更强大的 log 输出
alias glog='git log --oneline --graph --decorate --all'

alias h='history' # 快速查看历史命令
alias j='jobs' # 查看后台任务
alias psg='ps aux | grep' # 查找进程
alias du='du -h' # 显示磁盘使用（人类可读）
alias df='df -h' # 显示文件系统磁盘空间（人类可读）
alias free='free -m' # 查看内存使用
alias top='htop' # 使用更友好的 htop 代替 top

alias ip='ip -c' # 显示彩色输出的 ip 命令
alias flushdns='sudo systemd-resolve --flush-caches' # 刷新 DNS 缓存

alias tarx='tar -xvf' # 快速解压 tar 包
alias tarz='tar -cvzf' # 创建 gzip 压缩包
alias untar='tar -xvf' # 解压任意 tar 格式文件

alias zip='zip -r' # 压缩为 zip 格式
alias unzip='unzip -d' # 解压 zip 文件

alias 7z='7z x' # 解压 7z 文件
alias 7za='7z a' # 压缩为 7z 格式

alias grep='grep --color=auto' # 彩色高亮输出
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias find='find . -iname' # 快速查找文件（忽略大小写）
alias locate='locate --regex' # 使用正则表达式查找

# 快速搜索文本
alias rg='rg --hidden --follow' # 使用 ripgrep 递归搜索
alias ag='ag --hidden' # 使用 silversearcher-ag 搜索
alias fd='fd --hidden' # 使用 fd 搜索文件/目录

alias less='less -R' # 支持 ANSI 转义序列

alias lg='lazygit'
alias deg='double-entry-generator'
alias degtr='deg translate'

alias bcat='bat'
