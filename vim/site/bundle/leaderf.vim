"======================================================================
"
" init_leaderf.vim - 
"
" Created by skywind on 2020/03/01
" Last Modified: 2020/03/01 04:43:07
"
"======================================================================


"----------------------------------------------------------------------
" keymap
"----------------------------------------------------------------------
" CTRL+p 打开文件模糊匹配
let g:Lf_ShortcutF = '<D-p>'

" ALT+n 打开 buffer 模糊匹配
let g:Lf_ShortcutB = '<D-n>'
let g:Lf_MruMaxFiles = 2048
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
" let g:Lf_PreviewHorizontalPosition = 'center'
let g:Lf_PopupPreviewPosition='bottom'
let g:Lf_PreviewInPopup = 0
" let g:Lf_QuickSelect = 1
let g:Lf_QuickSelectAction = 't'
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'


noremap <m-g> :Leaderf --nowrap tasks<cr>
inoremap <m-g> <esc>:Leaderf --nowrap tasks<cr>

if has('gui_running')
    " noremap <c-f12> :Leaderf --nowrap tasks<cr>
    " inoremap <c-f12> <esc>:Leaderf --nowrap tasks<cr>
endif


"----------------------------------------------------------------------
" LeaderF
"----------------------------------------------------------------------
" 如何识别项目目录，从当前文件目录向父目录递归知道碰到下面的文件/目录
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_PopupWidth = 0.75
let g:Lf_CacheDirectory = expand('~/.vim/cache')

" 显示相对路径
let g:Lf_ShowRelativePath = 1

" 隐藏帮助
let g:Lf_HideHelp = 1
let g:Lf_NoChdir = 1

" 模糊匹配忽略扩展名
let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
            \ }

" MRU 文件忽略扩展名
let g:Lf_MruFileExclude = ['*.so', '*.exe', '*.py[co]', '*.sw?', '~$*', '*.bak', '*.tmp', '*.dll']
let g:Lf_MruMaxFiles = 2048
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PopupColorscheme = 'default'
let g:Lf_PopupColorscheme = 'gruvbox_default'
let g:Lf_ShortcutF = '<D-p>'
let g:Lf_ShortcutB = '<D-n>'
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

" 禁用 function/buftag 的预览功能，可以手动用 p 预览
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
let g:Lf_MruEnableFrecency = 1

let g:Lf_CommandMap = {'<C-k>': ['<C-p>', '<C-k>'], '<C-j>': ['<C-n>', '<C-j>']}

" 使用 ESC 键可以直接退出 leaderf 的 normal 模式
let g:Lf_NormalMap = {
        \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
        \ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<cr>']],
        \ "Mru": [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<cr>']],
        \ "Tag": [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<cr>']],
        \ "BufTag": [["<ESC>", ':exec g:Lf_py "bufTagExplManager.quit()"<cr>']],
        \ "Function": [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<cr>']],
        \ }

if (exists('*popup_create') && has('patch-8.1.2000')) || has('nvim-0.4')
    let g:Lf_WindowPosition = 'popup'
endif

let g:Lf_PreviewInPopup = 1


"----------------------------------------------------------------------
" preview 
"----------------------------------------------------------------------
let g:Lf_PreviewResult = {
        \ 'File': 0,
        \ 'Buffer': 0,
        \ 'Mru': 0,
        \ 'Tag': 0,
        \ 'BufTag': 0,
        \ 'Function': 0,
        \ 'Line': 0,
        \ 'Colorscheme': 0,
        \ 'Rg': 0,
        \ 'Gtags': 0,
        \ 'Snippet': 0,
        \}


"----------------------------------------------------------------------
" filer
"----------------------------------------------------------------------
let g:Lf_FilerShowPromptPath = 1
let g:Lf_FilerInsertMap = { '<Tab>': 'open_current', '<CR>': 'open_current',
    \ '<BS>': 'open_parent_or_backspace', '<up>': 'up', '<down>': 'down'}
let g:Lf_FilerNormalMap = {'i': 'switch_insert_mode', '<esc>': 'quit', 
    \ '~': 'goto_root_marker_dir', 'M': 'mkdir', 'T': 'create_file' }
" let g:Lf_FilerOnlyIconHighlight = 1


"----------------------------------------------------------------------
" ctags options
"----------------------------------------------------------------------
let g:Lf_CtagsFuncOpts = {
            \ "dosini": "--iniconf-kinds=s --language-force=iniconf",
            \ "taskini": "--iniconf-kinds=s --language-force=iniconf",
            \ }


"----------------------------------------------------------------------
" keymap
"----------------------------------------------------------------------
if get(g:, 'lf_disable_normal_map', 0) == 0
    nnoremap <leader>ff :<c-u>Leaderf file<cr>
    nnoremap <leader>fe :<c-u>Leaderf filer<cr>
    nnoremap <leader>fb :<c-u>Leaderf buffer<cr>
    nnoremap <leader>fM :<c-u>Leaderf mru<cr>
    nnoremap <leader>fg :<c-u>Leaderf gtags<cr>
    nnoremap <leader>fr :<c-u>Leaderf rg<cr>
    nnoremap <leader>fR :<c-u>Leaderf rg --live<cr>
    " nnoremap <leader>fw :<c-u>Leaderf window<cr>
    nnoremap <leader>fn :<c-u>Leaderf function<cr>
    nnoremap <leader>ft :<c-u>Leaderf tag<cr>
    nnoremap <leader>fu :<c-u>Leaderf bufTag<cr>
    nnoremap <leader>fs :<c-u>Leaderf self<cr>
    nnoremap <leader>fc :<c-u>Leaderf colorscheme<cr>
    nnoremap <leader>fy :<c-u>Leaderf cmdHistory<cr>
    " nnoremap <leader>fh :<c-u>Leaderf help<cr>
    nnoremap <leader>fj :<c-u>Leaderf jumps<cr>
    nnoremap <leader>fp :<c-u>Leaderf snippet<cr>
    nnoremap <leader>fq :<c-u>Leaderf quickfix<cr>
    nnoremap <leader>fa :<c-u>Leaderf tasks<cr>
    " filer
    nnoremap <leader>fd :exec 'Leaderf filer ' . shellescape(expand('%:p:h'))<cr>

    " basic keymaps
    " CTRL+n 打开最近使用的文件 MRU，进行模糊匹配
    noremap <D-n> :cclose<cr>:Leaderf --nowrap mru --regexMode<cr>

    " ALT+p 打开函数列表，按 i 进入模糊匹配，ESC 退出
    noremap <m-p> :cclose<cr>:Leaderf! --nowrap function<cr>

    " ALT+SHIFT+p 打开 tag 列表，i 进入模糊匹配，ESC退出
    noremap <m-P> :cclose<cr>:Leaderf! --nowrap bufTag<cr>

    " ALT+n 打开 buffer 列表进行模糊匹配
    noremap <m-n> :cclose<cr>:Leaderf! --nowrap buffer<cr>

    " ALT+m 全局 tags 模糊匹配
    noremap <m-m> :cclose<cr>:Leaderf --nowrap tag<cr>
endif

if get(g:, 'lf_disable_snippet_map', 0) == 0
    inoremap <c-x><c-x> <c-\><c-o>:Leaderf snippet<cr>
endif



