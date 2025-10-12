"----------------------------------------------------------------------
" LSP
"----------------------------------------------------------------------
let g:lsp_servers = get(g:, 'lsp_servers', {})

if executable('clangd')
    let g:lsp_servers.clangd = #{
                \ filetype: ['c', 'cpp', 'objc', 'objcpp', 'cuda'],
                \ path: 'clangd',
                \ args: ['--background-index'],
                \ root: ['.git', '.svn', '.root', '.project', '.hg'],
                \ }
endif

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


