"----------------------------------------------------------------------
" LSP
"----------------------------------------------------------------------
let g:lsp_servers = get(g:, 'lsp_servers', {})
let g:lsp_log_verbose = 1
let g:lsp_log_file = '~/vim-lsp.log'
let g:lsp_gopls_path = expand('~/go/bin/gopls')

if executable('clangd')
    let g:lsp_servers.clangd = #{
                \ filetype: ['c', 'cpp', 'objc', 'objcpp', 'cuda'],
                \ path: 'clangd',
                \ args: ['--background-index'],
                \ root: ['.git', '.svn', '.root', '.project', '.hg'],
                \ }
endif

if executable('pyrefly')
    let g:lsp_servers.pyrefly = #{
                \ filetype: 'python',
                \ path: 'pyrefly',
                \ args: ['lsp'],
                \ root: ['pyrefly.toml', 'pyproject.toml', '.git'],
                \ }
endif

if executable('gopls')
    let g:lsp_servers.gopls = #{
                \ filetype: 'go',
                \ path: 'gopls',
                \ args: ['serve'],
                \ initopts: {
                \   'semanticTokens': v:true,
                \ },
                \ }
endif

if has('mac') && executable('xcodebuild')
    " let g:sourcekit_lsp_path = trim(system('xcrun --find sourcekit-lsp'))
    let g:lsp_servers.sourcekit_lsp = #{
                \ filetype: ['swift', 'objc', 'objcpp'],
                \ path: 'xcrun',
                \ args: ['sourcekit-lsp'],
                \ root: ['.git', '.svn', 'buildServer.json', 'Package.swift'],
                \ features: {
                \   'signatureHelp': v:false,
                \ },
                \ }
endif
" yegappan 的文档中没有设置 \ root

" installed by npm -g vscode-langservers-extracted
if executable('vscode-css-language-server')
    let g:lsp_servers.css = #{
                \ filetype: ['css'],
                \ path: "vscode-css-language-server",
                \ args: ['--stdio'],
                \ root: ['.git', '.svn', '.root', '.project', '.hg'],
                \ }
    let g:lsp_servers.eslint = #{
                \ filetype: ['javascript'],
                \ path: "vscode-eslint-language-server",
                \ args: ['--stdio'],
                \ root: ['.git', '.svn', '.root', '.project', '.hg'],
                \ }
    let g:lsp_servers.html = #{
                \ filetype: ['html'],
                \ path: "vscode-html-language-server",
                \ args: ['--stdio'],
                \ root: ['.git', '.svn', '.root', '.project', '.hg'],
                \ }
    let g:lsp_servers.json = #{
                \ filetype: ['json'],
                \ path: "vscode-json-language-server",
                \ args: ['--stdio'],
                \ root: ['.git', '.svn', '.root', '.project', '.hg'],
                \ }
    let g:lsp_servers.markdown = #{
                \ filetype: ['markdown'],
                \ path: "vscode-markdown-language-server",
                \ args: ['--stdio'],
                \ root: ['.git', '.svn', '.root', '.project', '.hg'],
                \ }
endif

if get(g:, 'lsp', '') == 'yegappan'
    let g:lsp_servers.basics = #{
                \ filetype: ['vim', 'text', 'bash'],
                \ path: 'basics-language-server',
                \ args: ['--stdio'],
                \ root: ['.git', '.svn', '.root', '.project', '.hg'],
                \ }
endif


