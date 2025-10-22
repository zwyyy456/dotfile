"======================================================================
"
" yegappan.vim - yegappan/lsp configuration
"
" Created by skywind on 2025/09/28
" Last Modified: 2025/09/28 15:56:42
"
"======================================================================

"----------------------------------------------------------------------
" configuration
"----------------------------------------------------------------------
let s:lsp_opts = #{
        \   aleSupport: v:false,
        \   autoComplete: v:true,
        \   autoHighlight: v:false,
        \   autoHighlightDiags: v:false,
        \   autoPopulateDiags: v:false,
        \   completionMatcher: 'case',
        \   completionMatcherValue: 1,
        \   diagSignErrorText: 'E>',
        \   diagSignHintText: 'H>',
        \   diagSignInfoText: 'I>',
        \   diagSignWarningText: 'W>',
        \   echoSignature: v:true,
        \   hideDisabledCodeActions: v:false,
        \   highlightDiagInline: v:true,
        \   hoverInPreview: v:false,
        \   ignoreMissingServer: v:false,
        \   keepFocusInDiags: v:true,
        \   keepFocusInReferences: v:true,
        \   completionTextEdit: v:true,
        \   diagVirtualTextAlign: 'above',
        \   diagVirtualTextWrap: 'default',
        \   noNewlineInCompletion: v:true,
        \   omniComplete: v:true,
        \   outlineOnRight: v:false,
        \   outlineWinSize: 20,
        \   popupBorder: v:true,
        \   popupBorderHighlight: 'Title',
        \   popupBorderHighlightPeek: 'Special',
        \   popupBorderSignatureHelp: v:false,
        \   popupHighlightSignatureHelp: 'Pmenu',
        \   popupHighlight: 'Normal',
        \   semanticHighlight: v:true,
        \   showDiagInBalloon: v:true,
        \   showDiagInPopup: v:true,
        \   showDiagOnStatusLine: v:false,
        \   showDiagWithSign: v:true,
        \   showDiagWithVirtualText: v:false,
        \   showInlayHints: v:false,
        \   showSignature: v:true,
        \   snippetSupport: v:false,
        \   ultisnipsSupport: v:false,
        \   useBufferCompletion: v:false,
        \   usePopupInCodeAction: v:false,
        \   useQuickfixForLocations: v:false,
        \   vsnipSupport: v:false,
        \   bufferCompletionTimeout: 100,
        \   customCompletionKinds: v:false,
        \   completionKinds: {},
        \   filterCompletionDuplicates: v:true,
        \   condensedCompletionMenu: v:false,
        \ }


" \   semanticHighlightDelay: 200,
"----------------------------------------------------------------------
" internal
"----------------------------------------------------------------------
let s:lsp_servers = []


"----------------------------------------------------------------------
" check_back_space 
"----------------------------------------------------------------------
function! s:check_back_space() abort
      return col('.') < 2 || getline('.')[col('.') - 2]  =~# '\s'
endfunc


"----------------------------------------------------------------------
" TAB initialize
"----------------------------------------------------------------------
inoremap <silent><expr> <TAB> 
            \ pumvisible()? "\<c-n>" : 
            \ <SID>check_back_space()? "\<tab>" :
            \ "\<c-x>\<c-o>"

inoremap <silent><expr> <S-TAB> pumvisible()? "\<c-p>" : "\<s-tab>"


"----------------------------------------------------------------------
" Enter to confirm
"----------------------------------------------------------------------
" inoremap <silent><expr> <cr> pumvisible()? "\<c-y>" : "\<cr>"


"----------------------------------------------------------------------
" initialize
"----------------------------------------------------------------------
function! s:init_lsp() abort
    let l:lsp_opts = deepcopy(s:lsp_opts)
    let l:lsp_servers = get(g:, 'lsp_servers', {})
    if exists('g:yegappan_opts')
        for key in keys(g:yegappan_opts)
            let l:lsp_opts[key] = g:yegappan_opts[key]
        endfor
    endif
    call LspOptionsSet(l:lsp_opts)
    let servers = []
    for name in keys(l:lsp_servers)
        let info = l:lsp_servers[name]
        let ni = {}
        let ni.name = name
        let ni.path = get(info, 'path', '')
        let ni.args = get(info, 'args', [])
        if has_key(info, 'filetype')
            let ni.filetype = info.filetype
        endif
        if has_key(info, 'options')
            let ni.initializationOptions = info.options
        endif
        if has_key(info, 'workspace')
            let ni.workspaceConfig = info.workspace
        endif
        if has_key(info, 'initopts')
            let ni.initializationOptions = info.initopts
        endif
        if has_key(info, 'root')
            let rootmarkers = []
            for marker in info.root
                call add(rootmarkers, marker)
                call add(rootmarkers, marker . '/')
            endfor
            let ni.rootSearch = rootmarkers
        endif
        call add(servers, ni)
    endfor
    if len(servers) > 0
        " unsilent echom servers
        call LspAddServer(servers)
        noremap <silent> <c-.> :LspCodeAction<cr>
        noremap <silent> gd :LspGotoDefinition<cr>
        noremap <silent> gD :LspPeekDefinition<cr>
        noremap <silent> gn :LspShowSignature<cr>
        noremap <silent> <leader>fm :LspFormat<cr>

        " 搜索当前文件中的符号
        noremap <silent> gs ::LspDocumentSymbol<cr>
        " 在当前 workspace 中搜索符号
        noremap <silent> gS :LspSymbolSearch<cr>

        noremap <silent> gr :LspPeekReferences<cr>
        noremap <silent> gR :LspShowReferences<cr>

        noremap <silent> gI :LspGotoImpl<cr>

        " noremap <silent> gt :LspGotoTypeDef<cr>
        noremap <silent> <leader>rn :LspRename<cr>
        " 跳转到上一个错误处，循环跳转
        noremap <silent> g[ :LspDiag prevWrap<cr>
        " 跳转到下一个错误处，循环跳转
        noremap <silent> g] :LspDiag nextWrap<cr>
        noremap <silent> K :LspHover<cr>
        " show call hierarchy
        noremap <silent> gH :LspIncomingCalls<cr>
        noremap <silent> g< :LspIncomingCalls<cr>

        " 在弹出的窗口中预览函数定义
        " noremap <silent><M-;> :LspPeekDefinition<cr>
        
        " 设置 enter 确认补全但是不换行
        " inoremap <silent> <expr> <cr> pumvisible()? "\<c-y>\<C-e>" : "\<cr>"
    endif
    set noshowmode
endfunc


"----------------------------------------------------------------------
" autocmd
"----------------------------------------------------------------------
augroup YegappanLspInit
    au! 
    autocmd User LspSetup call s:init_lsp()
augroup END

augroup LspSetup
  au!
  au User LspAttached set completeopt-=noselect
augroup END

