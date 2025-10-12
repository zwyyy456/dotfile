set history=2000         " 命令历史记录
set viewdir=~/.vim/view  " 视图文件目录

"----------------------------------------------------------------------
" turn latest features
" 1. 增强的 diff 功能
" 2. 自动补全选项设置
" 3. blowfish2 加密
" 4. 光标行为优化
" 5. 检测到 fish 时改为使用 sh
"----------------------------------------------------------------------

" Enable vim-diff-enhanced (Christian Brabandt)
if has('patch-8.2.0001')
    set diffopt+=internal,algorithm:patience
    set diffopt+=indent-heuristic
endif

" complete option
if has('patch-8.0.1000')
    set completeopt=menuone,popup,noinsert
else
    set completeopt=menu,menuone
endif

" new blowfish2 
if has('patch-7.4.500') || v:version >= 800
    if !has('nvim')
        set cryptmethod=blowfish2
    endif
endif

" enable new-style cursorline (for numbers only)
if exists('+cursorlineopt')
    set cursorlineopt=number cursorline
endif

" setup shell 
if &shell =~# 'fish'
    set shell=sh
endif


"----------------------------------------------------------------------
" fixed cursor shaping compatible issues for some terminals
" 会导致光标形状无法随 vim 模式变化，碰到问题了再去韦易笑老师的 repo 中抄作业
"----------------------------------------------------------------------


"----------------------------------------------------------------------
" autocmd group
" 根据文件后缀添加对应的 filetype
"----------------------------------------------------------------------
augroup AscUnixGroup
    au!
    au FileType * call s:language_setup()
    au User VimScope call vimmake#toggle_quickfix(6, 1)
    au BufNewFile,BufRead *.as setlocal filetype=actionscript
    au BufNewFile,BufRead *.pro setlocal filetype=prolog
    au BufNewFile,BufRead *.es setlocal filetype=erlang
    au BufNewFile,BufRead *.asc setlocal filetype=asciidoc
    au BufNewFile,BufRead *.vl setlocal filetype=verilog
    au BufNewFile,BufRead *.bxrc setlocal filetype=bxrc
    au BufNewFile,BufRead *.odin setlocal filetype=odin
    au BufNewFile,BufRead *.comp setlocal filetype=comp
    au BufNewFIle,BufRead *.gpt setlocal filetype=gpt
    " au BufNewFile,BufRead *.md setlocal filetype=markdown
    au BufNewFile,BufRead *.lua.rename setlocal filetype=lua
    au BufNewFile,BufRead *.fmt setlocal filetype=protogen
augroup END


"----------------------------------------------------------------------
" language setup (on FileType autocmd)
" 对 qf 文件类型禁用行号
" 根据文件后缀加载对应的 tags 和 dict 文件
" 将折叠状态持久化
"----------------------------------------------------------------------
function! s:language_setup()
    " echom "FileType: " . &ft
    if &ft == 'qf'
        setlocal nonumber
    endif
    let tags = expand("~/.vim/tags/") . &ft . '.tags'
    let dict = expand("~/.vim/dict/") . &ft . '.dict'
    if filereadable(tags)
        exec "setlocal tags+=" . fnameescape(tags)
    endif
    if filereadable(dict)
        exec "setlocal dict+=" . fnameescape(dict)
    endif
endfunc


" Persistent folding information
function! s:fold_restore(enable)
    if a:enable == 'true' || a:enable == 'yes' || a:enable != 0
        augroup VimUnixFoldGroup
            au! 
            au BufWrite,VimLeave * silent! mkview
            au BufRead * silent! loadview
        augroup END
    else
        augroup VimUnixFoldGroup
            au!
        augroup END
    endif
endfunc

command! -nargs=1 PersistFoldEnable call s:fold_restore(<q-args>)


" turn off number and signcolumn for terminal
if has('terminal') && exists(':terminal') == 2
    if exists('##TerminalOpen')
        augroup VimUnixTerminalGroup
            au! 
            " au TerminalOpen * setlocal nonumber signcolumn=no
        augroup END
    endif
endif


