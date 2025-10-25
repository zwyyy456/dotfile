"======================================================================
"
" init-config.vim - 正常模式下的配置，在 init-basic.vim 后调用
"
" Created by skywind on 2018/05/30
" Last Modified: 2018/05/30 19:20:46
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :


"----------------------------------------------------------------------
" 设置 leaderkey 为 space, maplocalleader 为 "\"
" maplocalleader 可以用于特定 filetype 的快捷键
"----------------------------------------------------------------------
let mapleader = " "
let maplocalleader = "\\"

"----------------------------------------------------------------------
" 对 tmux 环境下和非 tmux 环境下设置不同的功能键超时（毫秒）
"----------------------------------------------------------------------
if $TMUX != ''
    set ttimeoutlen=30
elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
    set ttimeoutlen=80
endif


"----------------------------------------------------------------------
" 终端下允许 ALT，详见：http://www.skywind.me/blog/archives/2021
" 记得设置 ttimeout （见 init/basic.vim） 和 ttimeoutlen （上面）
" 实际设置内容转移到了 init/altmeta.vim 中
"----------------------------------------------------------------------


"----------------------------------------------------------------------
" 终端下功能键设置
"----------------------------------------------------------------------
function! s:key_escape(name, code)
    if has('nvim') == 0 && has('gui_running') == 0
        exec "set ".a:name."=\e".a:code
    endif
endfunc


"----------------------------------------------------------------------
" 功能键终端码矫正
"----------------------------------------------------------------------
call s:key_escape('<F1>', 'OP')
call s:key_escape('<F2>', 'OQ')
call s:key_escape('<F3>', 'OR')
call s:key_escape('<F4>', 'OS')
call s:key_escape('<S-F1>', '[1;2P')
call s:key_escape('<S-F2>', '[1;2Q')
call s:key_escape('<S-F3>', '[1;2R')
call s:key_escape('<S-F4>', '[1;2S')
call s:key_escape('<S-F5>', '[15;2~')
call s:key_escape('<S-F6>', '[17;2~')
call s:key_escape('<S-F7>', '[18;2~')
call s:key_escape('<S-F8>', '[19;2~')
call s:key_escape('<S-F9>', '[20;2~')
call s:key_escape('<S-F10>', '[21;2~')
call s:key_escape('<S-F11>', '[23;2~')
call s:key_escape('<S-F12>', '[24;2~')


"----------------------------------------------------------------------
" 防止tmux下vim的背景色显示异常
" Refer: http://sunaku.github.io/vim-256color-bce.html
"----------------------------------------------------------------------
if &term =~ '256color' && $TMUX != ''
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif


"----------------------------------------------------------------------
" 备份设置
"----------------------------------------------------------------------

" 允许备份
set backup

" 保存时备份
set writebackup

" 备份文件地址，统一管理
set backupdir=~/.vim/tmp

" 备份文件扩展名
set backupext=.bak

" 禁用交换文件
set noswapfile

" 禁用 undo文件
set noundofile

" 创建目录，并且忽略可能出现的警告
silent! call mkdir(expand('~/.vim/tmp'), "p", 0755)


"----------------------------------------------------------------------
" 配置微调
"----------------------------------------------------------------------

" 修正 ScureCRT/XShell 以及某些终端乱码问题，主要原因是不支持一些
" 终端控制命令，比如 cursor shaping 这类更改光标形状的 xterm 终端命令
" 会令一些支持 xterm 不完全的终端解析错误，显示为错误的字符，比如 q 字符
" 如果你确认你的终端支持，不会在一些不兼容的终端上运行该配置，可以注释
if has('nvim')
    set guicursor=
elseif (!has('gui_running')) && has('terminal') && has('patch-8.0.1200')
    let g:termcap_guicursor = &guicursor
    let g:termcap_t_RS = &t_RS
    let g:termcap_t_SH = &t_SH
    set guicursor=
    set t_RS=
    set t_SH=
endif

if has('unix')
    " 禁用 modifyOtherKeys（避免终端键位冲突）
    " 避免终端中打开 vim 时，光标形状异常或者闪烁
    if exists('+t_TI') && exists('+t_TE')
        let &t_TI = ''
        let &t_TE = ''
    endif

    " 检测是否为 FreeBSD 的 xterm
    let s:uname = system('uname')
    let s:xterm = 0
    if s:uname =~ "FreeBSD"
        let s:xterm = 1
    endif

    " 针对 xterm 的屏幕恢复配置，配置 t_ti 和 t_te 转义序列，确保
    " 退出 vim 后，终端内容不会混乱。
    if s:xterm != 0
        if &term =~ "xterm"
            let &t_ti="\0337\033[r\033[?47h"  " 进入终端时的初始化序列
            let &t_te="\033[?47l\0338"        " 退出终端时的恢复序列
            if has("terminfo")
                let &t_Sf="\033[3%p1%dm"      " 设置前景色
                let &t_Sb="\033[4%p1%dm"      " 设置背景色
            else
                let &t_Sf="\033[3%dm"
                let &t_Sb="\033[4%dm"
            endif
        endif
        set restorescreen  " 启用屏幕恢复
    endif
endif

" 打开文件时恢复上一次光标所在位置
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \     exe "normal! g`\"" |
    \ endif

" 定义一个 DiffOrig 命令用于查看文件改动
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif



"----------------------------------------------------------------------
" 文件类型微调
"----------------------------------------------------------------------
augroup InitFileTypesGroup

    " 清除同组的历史 autocommand
    au!

    " C/C++ 文件使用 // 作为注释
    au FileType c,cpp setlocal commentstring=//\ %s

    " markdown 允许自动换行
    au FileType markdown setlocal wrap

    " lisp 进行微调
    au FileType lisp setlocal ts=8 sts=2 sw=2 et

    " scala 微调
    au FileType scala setlocal sts=4 sw=4 noet

    " haskell 进行微调
    au FileType haskell setlocal et

    " quickfix 隐藏行号
    au FileType qf setlocal nonumber

    " 强制对某些扩展名的 filetype 进行纠正
    au BufNewFile,BufRead *.as setlocal filetype=actionscript
    au BufNewFile,BufRead *.pro setlocal filetype=prolog
    au BufNewFile,BufRead *.es setlocal filetype=erlang
    au BufNewFile,BufRead *.asc setlocal filetype=asciidoc
    au BufNewFile,BufRead *.vl setlocal filetype=verilog

augroup END

"----------------------------------------------------------------------
" 使得通过 browse 打开的打开的系统文件对话框，可以通过对话框右下角的
" 过滤器进行过滤。
"----------------------------------------------------------------------
function! s:Filter_Push(desc, wildcard)
    let g:browsefilter .= a:desc . " (" . a:wildcard . ")\t" . a:wildcard . "\n"
endfunc

let g:browsefilter = ''
call s:Filter_Push("All Files", "*")
call s:Filter_Push("C/C++/Object-C", "*.c;*.cpp;*.cc;*.h;*.hh;*.hpp;*.m;*.mm")
call s:Filter_Push("Python", "*.py;*.pyw")
call s:Filter_Push("Text", "*.txt")
call s:Filter_Push("Vim Script", "*.vim")



"----------------------------------------------------------------------
" command 模式的补全行为优化与窗口分割优化
"----------------------------------------------------------------------
if has('patch-8.0.0')
    set shortmess+=c
endif

set cpt=.,w,k

if has('patch-8.2.4500')
    set wildoptions+=pum,fuzzy
    set wildmode=longest,full
    " enter 只确认补全，不直接执行命令
    cnoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<cr>"
    " esc 只取消补全，不直接退出命令模式
    cnoremap <expr> <esc> pumvisible() ? "\<c-e>" : "\<esc>"
endif

if has('patch-9.0.648') || has('nvim-0.9.0')
    set splitkeep=screen
endif


"----------------------------------------------------------------------
" 优化 windows 下终端与 wsl 的兼容性
"----------------------------------------------------------------------
if asclib#platform#has('win')
    if has('nvim') == 0 && has('gui_running') == 0
        " fix: https://github.com/vim/vim/issues/13956
        exec 'set t_ut='
    endif
elseif asclib#platform#has_wsl()
    " fixed: vim will enter replace mode in wsl with cmd window
    exec 'set t_u7='
endif

"----------------------------------------------------------------------
" 插入模式：强制在标点符号后创建撤销断点 (Undo Breakpoint)
"----------------------------------------------------------------------
inoremap , ,<C-G>u
inoremap . .<C-G>u
inoremap ; ;<C-G>u


"----------------------------------------------------------------------
" 插入模式：完善补全设置
"----------------------------------------------------------------------

set completeopt=menuone,popup,noinsert

inoremap <silent> <c-e> <c-r>=SkipTextChangedI()<cr><c-e>
inoremap <silent> <c-y> <c-r>=SkipTextChangedI()<cr><c-y>

inoremap <silent><expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"