"----------------------------------------------------------------------
" GUI 的一些快捷键，例如打开文件浏览器，切换透明度，移动 tab 等更
" 依赖于 extra-tools.vim 中定义的一些函数
"----------------------------------------------------------------------
if has('gui_running') || (has('nvim') && (has('win32') || has('win64')))
    noremap <silent><A-o> :call Open_Browse(2)<cr>
    inoremap <silent><A-o> <ESC>:call Open_Browse(2)<cr>
    noremap <S-cr> o<ESC>
    noremap <c-cr> O<esc>
    noremap <M-Left> :call Tab_MoveLeft()<cr>
    noremap <M-Right> :call Tab_MoveRight()<cr>
    inoremap <M-Left> <ESC>:call Tab_MoveLeft()<cr>
    inoremap <M-Right> <ESC>:call Tab_MoveRight()<cr>
    if v:version >= 802
        tnoremap <M-Left> <c-\><c-N>:call Tab_MoveLeft()<cr>
        tnoremap <M-Right> <c-\><c-N>:call Tab_MoveRight()<cr>
    endif
    if has('gui_macvim')
        noremap <m-\|> :call Toggle_Transparency(9)<cr>
    else
        noremap <m-\|> :call Toggle_Transparency(15)<cr>
    endif
endif

if has('gui_running') || has('gui_macvim') || has('gui_mac')
    " new digraph
    inoremap <c--> <c-k>
    inoremap <c-_> <c-k>
endif


"----------------------------------------------------------------------
" 配置的 AsyncTask 相关的一些快捷键，依赖于 asynctasks.vim 中定义的
" AsyncTask 命令
" Todo 把 emake 的部分改成 cmake
"----------------------------------------------------------------------
noremap <silent><s-f12> :AsyncTaskEdit<cr>
inoremap <silent><s-f12> <ESC>:AsyncTaskEdit<cr>
noremap <silent><f12> :TaskFinder<cr>
inoremap <silent><f12> <ESC>:TaskFinder<cr>
noremap <silent><c-f12> :AsyncTaskEnviron profile debug release static<cr>
inoremap <silent><c-f12> <ESC>:AsyncTaskEnviron profile debug release static<cr>

noremap <silent><F5> :AsyncTask file-run<cr>
noremap <silent><F6> :AsyncTask make<cr>
noremap <silent><F7> :AsyncTask emake<cr>
noremap <silent><F8> :AsyncTask emake-exe<cr>
noremap <silent><F9> :AsyncTask file-build<cr>
noremap <silent><F10> :call asyncrun#quickfix_toggle(6)<cr>
noremap <silent><F11> :AsyncTask file-debug<cr>
noremap <silent><s-f5> :AsyncTask project-run<cr>
noremap <silent><s-f6> :AsyncTask project-test<cr>
noremap <silent><s-f7> :AsyncTask project-init<cr>
noremap <silent><s-f8> :AsyncTask project-install<cr>
noremap <silent><s-f9> :AsyncTask project-build<cr>
noremap <silent><s-f11> :AsyncTask project-debug<cr>

inoremap <silent><F5> <ESC>:AsyncTask file-run<cr>
inoremap <silent><F6> <ESC>:AsyncTask make<cr>
inoremap <silent><F7> <ESC>:AsyncTask emake<cr>
inoremap <silent><F8> <ESC>:AsyncTask emake-exe<cr>
inoremap <silent><F9> <ESC>:AsyncTask file-build<cr>
inoremap <silent><F10> <ESC>:call asyncrun#quickfix_toggle(6)<cr>
inoremap <silent><s-f5> <ESC>:AsyncTask project-run<cr>
inoremap <silent><s-f6> <ESC>:AsyncTask project-test<cr>
inoremap <silent><s-f7> <ESC>:AsyncTask project-init<cr>
inoremap <silent><s-f8> <ESC>:AsyncTask project-install<cr>
inoremap <silent><s-f9> <ESC>:AsyncTask project-build<cr>

noremap <silent><f1> :AsyncTask task-f1<cr>
noremap <silent><f2> :AsyncTask task-f2<cr>
noremap <silent><f3> :AsyncTask task-f3<cr>
noremap <silent><f4> :AsyncTask task-f4<cr>
noremap <silent><s-f1> :AsyncTask task-s-f1<cr>
noremap <silent><s-f2> :AsyncTask task-s-f2<cr>
noremap <silent><s-f3> :AsyncTask task-s-f3<cr>
noremap <silent><s-f4> :AsyncTask task-s-f4<cr>
inoremap <silent><f1> <ESC>:AsyncTask task-f1<cr>
inoremap <silent><f2> <ESC>:AsyncTask task-f2<cr>
inoremap <silent><f3> <ESC>:AsyncTask task-f3<cr>
inoremap <silent><f4> <ESC>:AsyncTask task-f4<cr>
inoremap <silent><s-f1> <ESC>:AsyncTask task-s-f1<cr>
inoremap <silent><s-f2> <ESC>:AsyncTask task-s-f2<cr>
inoremap <silent><s-f3> <ESC>:AsyncTask task-s-f3<cr>
inoremap <silent><s-f4> <ESC>:AsyncTask task-s-f4<cr>


"----------------------------------------------------------------------
" leader + j : 基于 AsyncRun 的异步 make
"----------------------------------------------------------------------
nnoremap <silent><leader>jj  :AsyncRun -cwd=<root> make<cr>
nnoremap <silent><leader>jc  :AsyncRun -cwd=<root> make clean<cr>
nnoremap <silent><leader>jk  :AsyncRun -mode=4 -cwd=<root> make run<cr>
nnoremap <silent><leader>jl  :AsyncRun -mode=4 -cwd=<root> make test<cr>
nnoremap <silent><leader>j1  :AsyncRun -mode=4 -cwd=<root> make t1<cr>
nnoremap <silent><leader>j2  :AsyncRun -mode=4 -cwd=<root> make t2<cr>
nnoremap <silent><leader>j3  :AsyncRun -mode=4 -cwd=<root> make t3<cr>
nnoremap <silent><leader>j4  :AsyncRun -mode=4 -cwd=<root> make t4<cr>
nnoremap <silent><leader>j5  :AsyncRun -mode=4 -cwd=<root> make t5<cr>
nnoremap <silent><leader>k1  :AsyncRun -cwd=<root> make t1<cr>
nnoremap <silent><leader>k2  :AsyncRun -cwd=<root> make t2<cr>
nnoremap <silent><leader>k3  :AsyncRun -cwd=<root> make t3<cr>
nnoremap <silent><leader>k4  :AsyncRun -cwd=<root> make t4<cr>
nnoremap <silent><leader>k5  :AsyncRun -cwd=<root> make t5<cr>

nnoremap <silent><leader>jm :call Tools_SwitchMakeFile()<cr>


"----------------------------------------------------------------------
" 设置 text-objects 的相关快捷键，使得 daz 可以删除全文
" dik 删除当前行（不包括首尾空白符），以及 dak
"----------------------------------------------------------------------
onoremap az :<c-u>normal! ggVG<cr>
vnoremap az ogg0oG$
" onoremap il :<c-u>normal! v$o^oh<cr>
" vnoremap il $o^oh

vnoremap ik 0o$h
onoremap ik :normal vik<cr>
vnoremap ak 0o$
onoremap ak :normal vak<cr>


"----------------------------------------------------------------------
"- quickui buffer switch / bufferhint
" 设置 + 为 bufferhint 或者 quickui buffer switch 的快捷键
" 用于提供一个交互式的 buffer 切换界面
"----------------------------------------------------------------------
if has('patch-8.2.1') || has('nvim-0.4')
    nnoremap <silent>+ :call quickui#tools#list_buffer('FileSwitch tabe')<cr>
else
    nnoremap + :call bufferhint#Popup()<CR>
endif


"----------------------------------------------------------------------
" 映射基于 cscope 的代码导航与生成更新 tags、scope 数据的快捷键
"----------------------------------------------------------------------
if has("cscope")
    noremap <silent> <leader>cs :VimScope s <C-R><C-W><CR>
    noremap <silent> <leader>cg :VimScope g <C-R><C-W><CR>
    noremap <silent> <leader>cc :VimScope c <C-R><C-W><CR>
    noremap <silent> <leader>ct :VimScope t <C-R><C-W><CR>
    noremap <silent> <leader>ce :VimScope e <C-R><C-W><CR>
    noremap <silent> <leader>cd :VimScope d <C-R><C-W><CR>
    noremap <silent> <leader>ca :VimScope a <C-R><C-W><CR>
    noremap <silent> <leader>cf :VimScope f <C-R><C-W><CR>
    noremap <silent> <leader>ci :VimScope i <C-R><C-W><CR>
    if v:version >= 800 || has('patch-7.4.2038')
        set cscopequickfix=s+,c+,d+,i+,t+,e+,g+,f+,a+
    else
        set cscopequickfix=s+,c+,d+,i+,t+,e+,g+,f+
    endif
endif

nnoremap <leader>cb1 :call vimmake#update_tags('', 'ctags', '.tags')<cr>
nnoremap <leader>cb2 :call vimmake#update_tags('', 'cs', '.cscope')<cr>
nnoremap <leader>cb3 :call vimmake#update_tags('!', 'ctags', '.tags')<cr>
nnoremap <leader>cb4 :call vimmake#update_tags('!', 'cs', '.cscope')<cr>
nnoremap <leader>cb5 :call vimmake#update_tags('', 'py', '.cscopy')<cr>
nnoremap <leader>cb6 :call vimmake#update_tags('!', 'py', '.cscopy')<cr>


"----------------------------------------------------------------------
" 添加在 quickui 和 asclib 的窗口中上下滚动的快捷键
"----------------------------------------------------------------------
" noremap <silent><M-[> :call asclib#quickfix#scroll(2)<cr>
" noremap <silent><M-]> :call asclib#quickfix#scroll(3)<cr>
" noremap <silent><M-{> :call asclib#quickfix#scroll(4)<cr>
" noremap <silent><M-}> :call asclib#quickfix#scroll(5)<cr>
noremap <silent><M-u> :call asclib#window#scroll('#', 6)<cr>
noremap <silent><M-d> :call asclib#window#scroll('#', 7)<cr>
noremap <silent><M-U> :call quickui#preview#scroll(-1)<cr>
noremap <silent><M-D> :call quickui#preview#scroll(1)<cr>

" inoremap <silent><M-[> <c-\><c-o>:call asclib#quickfix#scroll(2)<cr>
" inoremap <silent><M-]> <c-\><c-o>:call asclib#quickfix#scroll(3)<cr>
" inoremap <silent><M-{> <c-\><c-o>:call asclib#quickfix#scroll(4)<cr>
" inoremap <silent><M-}> <c-\><c-o>:call asclib#quickfix#scroll(5)<cr>
inoremap <silent><M-u> <c-\><c-o>:call asclib#window#scroll('#', 6)<cr>
inoremap <silent><M-d> <c-\><c-o>:call asclib#window#scroll('#', 7)<cr>


"----------------------------------------------------------------------
" leader + h : fast open files
" 定义了一系列基于 commands.vim  快速打开文件的快捷键
" TODO 可以改造，不太用得上
"----------------------------------------------------------------------
nnoremap <silent><leader>hp :FileSwitch ~/.vim/project.txt<cr>
nnoremap <silent><leader>hf <c-w>gf
nnoremap <silent><leader>he :call Show_Explore()<cr>
nnoremap <silent><leader>hb :FileSwitch ~/.vim/bundle.vim<cr>
nnoremap <silent><leader>hq :FileSwitch ~/.vim/quicknote.txt<cr>
nnoremap <silent><leader>hm :FileSwitch +setl\ ft=markdown ~/.vim/quicknote.md<cr>
nnoremap <silent><leader>hg :FileSwitch ~/.vim/scratch.txt<cr>
nnoremap <silent><leader>hd :FileSwitch ~/.vim/notes.md<cr>
nnoremap <silent><leader>ho :FileSwitch ~/.vim/cloud/Documents/cloudnote.txt<cr>
nnoremap <silent><leader>hi :FileSwitch ~/.vim/tasks.ini<cr>
nnoremap <silent><leader>ha :
nnoremap <silent><leader>h; :call asclib#nextcloud_sync()<cr>

if (!has('nvim')) && (has('win32') || has('win64'))
    nnoremap <silent><leader>hr :FileSwitch ~/_vimrc<cr>
elseif !has('nvim')
    nnoremap <silent><leader>hr :FileSwitch ~/.vimrc<cr>
else
    nnoremap <silent><leader>hr :FileSwitch ~/.config/nvim/init.vim<cr>
endif

if has('nvim') == 0
    nnoremap <silent><leader>hl :FileSwitch ~/.vim/local.vim<cr>
else
    nnoremap <silent><leader>hl :FileSwitch ~/.config/nvim/local.vim<cr>
endif

let $RTP = expand('<sfile>:p:h:h')
nnoremap <silent><leader>hk :FileSwitch $RTP/init/keymaps.vim<cr>
nnoremap <silent><leader>hs :FileSwitch $RTP/skywind.vim<cr>
nnoremap <silent><leader>hv :FileSwitch $RTP/bundle.vim<cr>
nnoremap <silent><leader>hc :FileSwitch $RTP/autoload/asclib.vim<cr>
nnoremap <silent><leader>hu :FileSwitch $RTP/autoload/auxlib.vim<cr>
nnoremap <silent><leader>ht :FileSwitch $RTP/tasks.ini<cr>

if has('win32') || has('win16') || has('win95') || has('win64')
    let s:autohk = expand('~/AppData/Roaming/Microsoft/Windows/Start Menu')
    let s:autohk = s:autohk . '/Programs/Startup/quickkeys.ahk'
    exec 'nnoremap <leader>ha :FileSwitch '. fnameescape(s:autohk). ' <cr>'
endif

let s:nvimrc = expand("~/.config/nvim/init.vim")
if has('win32') || has('win16') || has('win95') || has('win64')
    let s:nvimrc = expand("~/AppData/Local/nvim/init.vim")
endif
exec 'nnoremap <leader>h. :FileSwitch '.fnameescape(s:nvimrc).'<cr>'

nnoremap <leader>hn :FileSwitch $RTP/neovim.lua<cr>


"----------------------------------------------------------------------
" 创建了一些基于 asclib 的 python 代码检查、C++ 代码检查与性能分析、html 
" 代码格式化的快捷键映射
"
"----------------------------------------------------------------------
nnoremap <silent><leader>lp :call asclib#lint_pylint('')<cr>
nnoremap <silent><leader>lf :call asclib#lint_flake8('')<cr>
nnoremap <silent><leader>ls :call asclib#lint_splint('')<cr>
nnoremap <silent><leader>lc :call asclib#lint_cppcheck('')<cr>
nnoremap <silent><leader>lg :call asclib#open_gprof('', '')<cr>
nnoremap <silent><leader>lt :call asclib#html_prettify()<cr>

" last command
nnoremap <leader>ll :<c-p><cr>


"----------------------------------------------------------------------
" quickmenu
" 创建了一些基于 quickmenu 的打开或者关闭快速菜单的快捷键映射、基于 vim-preview
" 的 tag 预览的快捷键映射、基于 asclib 的文件创建的快捷键映射
"----------------------------------------------------------------------
noremap <silent><c-f10> :call quickmenu#toggle(1)<cr>
inoremap <silent><c-f10> <ESC>:call quickmenu#toggle(1)<cr>
noremap <silent><c-f11> :call quickmenu#toggle(2)<cr>
inoremap <silent><c-f11> <ESC>:call quickmenu#toggle(2)<cr>

" 不再使用 preview.vim 插件，g5 快捷键空出来了
" nnoremap <silent>g5 :PreviewTag<cr>
nnoremap <silent><leader>ww :call asclib#touch_file('wsgi')<cr>

nnoremap <leader>m0 :call quickmenu#toggle(0)<cr>
nnoremap <leader>m1 :call quickmenu#toggle(1)<cr>
nnoremap <leader>m2 :call quickmenu#toggle(2)<cr>
nnoremap <leader>m3 :call quickmenu#toggle(3)<cr>


"----------------------------------------------------------------------
" others
" 创建了对齐选中文本、将函数声明末尾分号转换成 {}、quickui 中展示函数列表的快捷键映射
"----------------------------------------------------------------------
nnoremap <silent><leader>at :MyCheatSheetAlign<cr>
vnoremap <silent><leader>at :MyCheatSheetAlign<cr>
nnoremap <silent><leader>ab :CppBraceExpand<cr>
vnoremap <silent><leader>ab :CppBraceExpand<cr>

noremap <m-i> :call quickui#tools#list_function()<cr>
noremap <m-I> :call quickui#tools#list_function()<cr>
noremap <m-y> :call quickui#tools#list_function()<cr>

if has('gui_macvim')
    noremap <d-i> :call quickui#tools#list_function()<cr>
    noremap <d-I> :call quickui#tools#list_function()<cr>
    noremap <d-y> :call quickui#tools#list_function()<cr>
endif


"----------------------------------------------------------------------
" Tabularize
" 配置使用 Tabularize 进行表格对齐的快捷键映射
"----------------------------------------------------------------------
nnoremap \tb= :Tabularize /=<CR>
vnoremap \tb= :Tabularize /=<CR>
nnoremap \tb/ :Tabularize /\/\//l4c1<CR>
vnoremap \tb/ :Tabularize /\/\//l4c1<CR>
nnoremap \tb* :Tabularize /\/\*/l4c1<cr>
vnoremap \tb* :Tabularize /\/\*/l4c1<cr>
nnoremap \tb, :Tabularize /,/r0l1<CR>
vnoremap \tb, :Tabularize /,/r0l1<CR>
nnoremap \tbl :Tabularize /\|<cr>
vnoremap \tbl :Tabularize /\|<cr>
nnoremap \tbc :Tabularize /#/l4c1<cr>
vnoremap \tbc :Tabularize /#/l4c1<cr>
nnoremap \tb<bar> :Tabularize /\|<cr>
vnoremap \tb<bar> :Tabularize /\|<cr>
nnoremap \tbr :Tabularize /\|/r0<cr>
vnoremap \tbr :Tabularize /\|/r0<cr>



"----------------------------------------------------------------------
" Sneak
" 配置使用 Sneak 进行快速跳转的快捷键映射
"----------------------------------------------------------------------
" nmap gz <Plug>Sneak_s
" nmap gZ <Plug>Sneak_S
" vmap gz <Plug>Sneak_s
" vmap gZ <Plug>Sneak_S
" xmap gz <Plug>Sneak_s
" xmap gZ <Plug>Sneak_S


"----------------------------------------------------------------------
" grammarous
" 配置使用 grammarous 进行语法检查的快捷键映射
"----------------------------------------------------------------------
map <leader>rr <Plug>(grammarous-open-info-window)
map <leader>rv <Plug>(grammarous-move-to-info-window)
map <leader>rs <Plug>(grammarous-reset)
map <leader>rx <Plug>(grammarous-close-info-window)
map <leader>rm <Plug>(grammarous-remove-error)
map <leader>rd <Plug>(grammarous-disable-rule)
map <leader>rn <Plug>(grammarous-move-to-next-error)
map <leader>rp <Plug>(grammarous-move-to-previous-error)


"----------------------------------------------------------------------
" space + t : toggle plugins
"----------------------------------------------------------------------
noremap <silent><S-F10> :call quickmenu#toggle(0)<cr>
inoremap <silent><S-F10> <ESC>:call quickmenu#toggle(0)<cr>

if has('autocmd')
    function! s:insert_enter()
        if get(g:, 'echodoc#enable_at_startup', 0) != 0
            set noshowmode
        elseif exists(':CocInstall')
            set noshowmode
        endif
    endfunc
    function! s:insert_leave()
        if get(g:, 'echodoc#enable_at_startup', 0) != 0
            set showmode
        elseif exists(':CocInstall')
            set showmode
        endif
    endfunc
    augroup AscKeymapsAu
        autocmd!
        autocmd InsertLeave * call s:insert_leave()
        autocmd InsertEnter * call s:insert_enter()
        " autocmd InsertLeave * set showmode
        if exists('##TerminalOpen')
            autocmd TerminalOpen * setlocal ft=terminal
        elseif exists('##TermOpen')
            autocmd TermOpen * setlocal ft=terminal
        endif
    augroup END
endif

" PreviewSignature 的功能可以由 lsp 插件提供，不需要用 preview.vim 插件
" preview.vim 插件已被弃用，不再维护
"

"----------------------------------------------------------------------
" go back and go front
"----------------------------------------------------------------------
