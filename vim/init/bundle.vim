"======================================================================
"
" init-plugins.vim - 
"
" Created by skywind on 2018/05/31
" Last Modified: 2018/06/10 23:11
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :


"----------------------------------------------------------------------
" system detection 
"----------------------------------------------------------------------
let s:uname = asclib#platform#uname()
let g:bundle#uname = s:uname
let g:bundle#windows = (s:uname == 'windows')? 1 : 0


"----------------------------------------------------------------------
" 默认情况下的分组，可以再前面覆盖之
"----------------------------------------------------------------------
if !exists('g:bundle_group')
    let g:bundle_group = ['simple', 'basic', 'enhanced', 'filetypes', 'textobj']
    let g:bundle_group += ['tags', 'airline', 'nerdtree', 'echodoc']
    let g:bundle_group += ['leaderf', 'stargate', 'navigator']
    let g:bundle_group += ['yegappan', 'grammer', 'asynctasks', 'cpp']
endif

let g:bundle_enabled = {}
for key in g:bundle_group | let g:bundle_enabled[key] = 1 | endfor
let s:enabled = g:bundle_enabled


"----------------------------------------------------------------------
" 计算当前 vim-init 的子路径
"----------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

if !exists(':IncScript')
    command! IncScript -nargs=1 exec 'so ' . fnameescape(s:home .'/<args>')
endif

function! bundle#path(path)
    let path = expand(s:home . '/' . a:path )
    return substitute(path, '\\', '/', 'g')
endfunc

function! s:path(path)
    return bundle#path(a:path)
endfunc


"----------------------------------------------------------------------
" 默认在 ~/.vim/bundles 下安装插件
"----------------------------------------------------------------------
call plug#begin(get(g:, 'bundle_home', '~/.vim/bundles'))


"----------------------------------------------------------------------
" 默认插件（simple） 
"----------------------------------------------------------------------
if has_key(s:enabled, 'simple')
    " 文件浏览器，代替 netrw
    Plug 'justinmk/vim-dirvish'

    " 快速移动，通过 s{char}{char} 触发，类似 nvim 的 flash.nvim
    Plug 'justinmk/vim-sneak'
    
    " Git 支持
    Plug 'tpope/vim-fugitive'

    " 缓冲区、标签导航
    Plug 'tpope/vim-unimpaired' " 已经内置
    
    " 表格对齐，使用命令 Tabularize
    Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

    " 在预定义的值之间循环
    Plug 'bootleq/vim-cycle'
    
    " 提供快速修改删除包围符号（如 "）的功能
    Plug 'tpope/vim-surround'

    " 智能自动补全 {} 等分隔符
    " Plug 'LunarWatcher/auto-pairs'
    Plug 'zwyyy456/delimitMate'

    " 搜索后开始编译或者移动时自动取消高亮
    " Plug 'romainl/vim-cool'
    
    " 全文快速移动，<leader><leader>f{char} 即可触发
    if has_key(s:enabled, 'stargate') && has('nvim') == 0 && v:version >= 900
        Plug 'monkoose/vim9-stargate'
        IncScript site/bundle/stargate.vim
    else
        Plug 'easymotion/vim-easymotion'
        IncScript site/bundle/easymotion.vim
    endif


    " Diff 增强，支持 histogram / patience 等更科学的 diff 算法
    Plug 'chrisbra/vim-diff-enhanced'
    
    " 通过配置快捷键等方式增强 vim 自带终端的使用体验
    Plug 'skywind3000/vim-terminal-help'
    
    " 安装 sublime 主题
    Plug 'zwyyy456/vim-sublime-monokai'


    IncScript site/bundle/dirvish.vim
    IncScript site/bundle/cycle.vim
    IncScript site/bundle/auto-pairs.vim
endif

"----------------------------------------------------------------------
" 基础插件
"----------------------------------------------------------------------
if has_key(s:enabled, 'basic')

    " 展示开始画面，显示最近编辑过的文件
    Plug 'mhinz/vim-startify'


    " 支持库，给其他插件用的函数库
    Plug 'xolox/vim-misc'

    " 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
    Plug 'kshenoy/vim-signature'

    " 用于在侧边符号栏显示 git/svn 的 diff
    Plug 'mhinz/vim-signify'

    " 根据 quickfix 中匹配到的错误信息，高亮对应文件的错误行
    " 使用 :RemoveErrorMarkers 命令或者 <leader>ha 清除错误
    Plug 'mh21/errormarker.vim'

    " 使用 ALT+e 会在不同窗口/标签上显示 A/B/C 等编号，然后字母直接跳转
    Plug 't9md/vim-choosewin'


    " 使用 ALT+E 来选择窗口
    nmap <m-e> <Plug>(choosewin)

    " 默认不显示 startify
    let g:startify_disable_at_vimenter = 1
    let g:startify_session_dir = '~/.vim/session'

    " 使用 <leader>cM 清除 errormarker 标注的错误
    let g:errormarker_disablemappings = 1
    nnoremap <silent> <leader>cm :ErrorAtCursor<CR>
    nnoremap <silent> <leader>cM :RemoveErrorMarkers<cr>

    " signify 调优
    let g:signify_vcs_list = ['git', 'svn']
    let g:signify_sign_add               = '+'
    let g:signify_sign_delete            = '_'
    let g:signify_sign_delete_first_line = '‾'
    let g:signify_sign_change            = '~'
    let g:signify_sign_changedelete      = g:signify_sign_change

    " git 仓库使用 histogram 算法进行 diff
    let g:signify_vcs_cmds = {
            \ 'git': 'git diff --no-color --diff-algorithm=histogram --no-ext-diff -U0 -- %f',
            \}
endif


"----------------------------------------------------------------------
" 增强插件
"----------------------------------------------------------------------
if has_key(s:enabled, 'enhanced')

    " 用 v 选中一个区域后，ALT_+/- 按分隔符扩大/缩小选区
    Plug 'terryma/vim-expand-region'

    " 快速文件搜索
    Plug 'junegunn/fzf'

    " 给不同语言提供字典补全，插入模式下 c-x c-k 触发
    Plug 'asins/vim-dict'

    " 使用 :FlyGrep 命令进行实时 grep
    Plug 'wsdjeg/FlyGrep.vim'

    " 使用 :CtrlSF 命令进行模仿 sublime 的 grep
    Plug 'dyng/ctrlsf.vim'

    " 提供 gist 接口
    Plug 'lambdalisue/vim-gista', { 'on': 'Gista' }
    
    " 安装 quickui 插件
    Plug 'skywind3000/vim-quickui'

    " 安装 quickmenu 插件
    Plug 'skywind3000/quickmenu.vim'
    
    " 使用 Plug 管理 commentary.vim 插件
    Plug 'tpope/vim-commentary'
    
    
    " ALT_+/- 用于按分隔符扩大缩小 v 选区
    map <m-=> <Plug>(expand_region_expand)
    map <m--> <Plug>(expand_region_shrink)
    
endif


"----------------------------------------------------------------------
" vim 任务异步运行插件
"----------------------------------------------------------------------
if has_key(s:enabled, 'asynctasks')
    " 使用 Plug 管理 asyncrun 插件
    Plug 'skywind3000/asyncrun.vim'

    "使用 Plug 管理 asynctasks 插件
    Plug 'skywind3000/asynctasks.vim'
endif


"----------------------------------------------------------------------
" vim-navigator: which-key 的替代品
"----------------------------------------------------------------------
if has_key(s:enabled, 'navigator')
    Plug 'skywind3000/vim-navigator'
    IncScript site/bundle/navigator.vim
endif

"----------------------------------------------------------------------
" 自动生成 ctags/gtags，并提供自动索引功能
" 不在 git/svn 内的项目，需要在项目根目录 touch 一个空的 .root 文件
" 详细用法见：https://zhuanlan.zhihu.com/p/36279445
"----------------------------------------------------------------------
if has_key(s:enabled, 'tags')

    " 提供 ctags/gtags 后台数据库自动更新功能
    Plug 'skywind3000/vim-gutentags'

    " 提供 GscopeFind 命令并自动处理好 gtags 数据库切换
    " 支持光标移动到符号名上：<leader>cg 查看定义，<leader>cs 查看引用
    Plug 'skywind3000/gutentags_plus'

    IncScript site/bundle/gtags.vim
endif


"----------------------------------------------------------------------
" 文本对象：textobj 全家桶
"----------------------------------------------------------------------
if has_key(s:enabled, 'textobj')

    " 基础插件：提供让用户方便的自定义文本对象的接口
    Plug 'kana/vim-textobj-user'

    " indent 文本对象：ii/ai 表示当前缩进，vii 选中当缩进，cii 改写缩进
    " vim-indent-object 插件改为 Plug 管理
    Plug 'michaeljsmith/vim-indent-object'

    " 语法文本对象：iy/ay 基于语法的文本对象
    Plug 'kana/vim-textobj-syntax'

    " 函数文本对象：if/af 支持 c/c++/vim/java
    Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }

    " 参数文本对象：i,/a, 包括参数或者列表元素
    Plug 'sgur/vim-textobj-parameter'

    " 提供 python 相关文本对象，if/af 表示函数，ic/ac 表示类
    Plug 'bps/vim-textobj-python', {'for': 'python'}

    " 提供 uri/url 的文本对象，iu/au 表示
    Plug 'jceb/vim-textobj-uri'
    
endif


"----------------------------------------------------------------------
" 文件类型扩展
"----------------------------------------------------------------------
if has_key(s:enabled, 'filetypes')

    " powershell 脚本文件的语法高亮
    Plug 'pprovost/vim-ps1', { 'for': 'ps1' }

    " lua 语法高亮增强
    Plug 'tbastos/vim-lua', { 'for': 'lua' }

    " C++ 语法高亮增强，支持 11/14/17 标准
    Plug 'bfrg/vim-c-cpp-modern', { 'for': ['c', 'cpp'] }
    Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }

    " 额外语法文件
    Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }

    " python 语法文件增强
    Plug 'vim-python/python-syntax', { 'for': ['python'] }

    " rust 语法增强
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }

    " vim org-mode 
    Plug 'jceb/vim-orgmode', { 'for': 'org' }
endif


"----------------------------------------------------------------------
" airline
"----------------------------------------------------------------------
if has_key(s:enabled, 'airline')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    IncScript site/bundle/airline.vim
endif


"----------------------------------------------------------------------
" NERDTree
"----------------------------------------------------------------------
if has_key(s:enabled, 'nerdtree')
    Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeCWD', 'NERDTreeFind'] }
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    IncScript site/bundle/nerdtree.vim
endif


"----------------------------------------------------------------------
" LanguageTool 语法检查
"----------------------------------------------------------------------
if has_key(s:enabled, 'grammer')
    Plug 'rhysd/vim-grammarous'
    noremap <leader>rg :GrammarousCheck --lang=en-US --no-move-to-first-error --no-preview<cr>
endif


"----------------------------------------------------------------------
" ale：动态语法检查
"----------------------------------------------------------------------
if has_key(s:enabled, 'ale')
    Plug 'w0rp/ale'
    IncScript site/bundle/ale.vim
endif


"----------------------------------------------------------------------
" echodoc：搭配 YCM/deoplete 在底部显示函数参数
"----------------------------------------------------------------------
if has_key(s:enabled, 'echodoc')
    Plug 'Shougo/echodoc.vim'
    set noshowmode
    let g:echodoc#enable_at_startup = 1
endif


"----------------------------------------------------------------------
" LeaderF：CtrlP / FZF 的超级代替者，文件模糊匹配，tags/函数名 选择
"----------------------------------------------------------------------
if has_key(s:enabled, 'leaderf')
    " 如果 vim 支持 python 则启用  Leaderf
    if has('python') || has('python3')
        Plug 'Yggdroot/LeaderF'
        Plug 'tamago324/LeaderF-filer'
        Plug 'voldikss/LeaderF-emoji'
        Plug 'skywind3000/LeaderF-snippet'
        IncScript site/bundle/leaderf.vim

    else
        " 不支持 python ，使用 CtrlP 代替
        Plug 'ctrlpvim/ctrlp.vim'

        " 显示函数列表的扩展插件
        Plug 'tacahiroy/ctrlp-funky'
        
        IncScript site/bundle/ctrlp.vim

    endif
endif


"----------------------------------------------------------------------
" Lsp 插件
"----------------------------------------------------------------------
if has_key(s:enabled, 'lsp')
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'mattn/vim-lsp-settings'
    Plug 'prabirshrestha/asyncomplete-buffer.vim'
    Plug 'prabirshrestha/asyncomplete-tags.vim'
    Plug 'prabirshrestha/asyncomplete-file.vim'
    Plug 'jsit/asyncomplete-user.vim'
    IncScript site/bundle/lsp.vim
endif


"----------------------------------------------------------------------
" yegappan 的 Lsp 插件，函数跳转与补全一应俱全
"----------------------------------------------------------------------
if has_key(s:enabled, 'yegappan')
    if v:version >= 901 && has('nvim') == 0
        Plug 'yegappan/lsp'
        IncScript site/samples/lsp_servers.vim
        IncScript site/bundle/yegappan.vim
    endif
endif

"----------------------------------------------------------------------
" Cpp 相关插件
"----------------------------------------------------------------------
if has_key(s:enabled, 'cpp')
    Plug 'skywind3000/vim-cppman'
endif

if has_key(s:enabled, 'swift')
    Plug 'keith/swift.vim', { 'for': 'swift' }
endif

"----------------------------------------------------------------------
" 结束插件安装
"----------------------------------------------------------------------
call plug#end()

