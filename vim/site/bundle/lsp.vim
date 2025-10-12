" vim: set ts=4 sw=4 tw=78 noet :
"======================================================================
"
" lsp.vim - LSP config
"
" Created by skywind on 2022/12/05
" Last Modified: 2022/12/06 03:51
"
"======================================================================


"----------------------------------------------------------------------
" turning lsp
"----------------------------------------------------------------------
let g:lsp_use_lua = has('nvim-0.4.0') || (has('lua') && has('patch-8.2.0775'))
let g:lsp_completion_documentation_enabled = 0
let g:lsp_diagnostics_enabled = 0
let g:lsp_diagnostics_signs_enabled = 0
let g:lsp_diagnostics_highlights_enabled = 0
let g:lsp_document_code_action_signs_enabled = 0

let g:lsp_signature_help_enabled = 0
let g:lsp_document_highlight_enabled = 1
let g:lsp_preview_fixup_conceal = 1
let g:lsp_hover_conceal = 1


"----------------------------------------------------------------------
" turning completion
"----------------------------------------------------------------------
let g:asyncomplete_min_chars = 2
let g:asyncomplete_auto_completeopt = 0

set shortmess+=c


"----------------------------------------------------------------------
" popup
"----------------------------------------------------------------------
hi! PopupWindow ctermbg=236 guibg=#303030

function! s:preview_open()
    let wid = lsp#document_hover_preview_winid()
    hi! PopupWindow ctermbg=236 guibg=#303030
    echom "popup opened"
    if has('nvim') == 0
        call setwinvar(wid, '&wincolor', 'PopupWindow')
        " call win_execute(wid, 'syn clear')
        " call win_execute(wid, 'unsilent echom "ft: " . &ft')
    else
        call nvim_win_set_option(wid, 'winhighlight', 'Normal:PopupWindow')
    endif
endfunc

function! s:preview_close()
endfunc

augroup Lsp_FloatColor2
    au!
    autocmd User lsp_float_opened call s:preview_open()
    autocmd User lsp_float_closed call s:preview_close()
augroup END


"----------------------------------------------------------------------
" keymaps
"----------------------------------------------------------------------
" tab 和 shift-tab 时，如果补全框已显示，则切换到下一个补全项，否则执行普通 tab
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" 按下 enter 时，完成补全，不插入新行
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
" 按下 enter 时，插入新行
" inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunc

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ asyncomplete#force_refresh()

" inoremap <silent><expr> .  ("." . asyncomplete#force_refresh())



"----------------------------------------------------------------------
" 设置跳转到函数定义、引用等功能的快捷键
"----------------------------------------------------------------------
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    " 由 gtag 或者 ctag 来处理 PreviewTag
    " vim-preview 目前应该是无法处理 lsp 返回的 tag
    " if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    noremap <buffer> gd <plug>(lsp-definition)
    noremap <buffer> gs <plug>(lsp-document-symbol-search)
    noremap <buffer> gS <plug>(lsp-workspace-symbol-search)
    noremap <buffer> gr <plug>(lsp-references)
    noremap <buffer> gI <plug>(lsp-implementation)
    noremap <buffer> gt <plug>(lsp-type-definition)
    noremap <buffer> <leader>rn <plug>(lsp-rename)
    noremap <buffer> g[ <plug>(lsp-previous-diagnostic)
    noremap <buffer> g] <plug>(lsp-next-diagnostic)
    noremap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

