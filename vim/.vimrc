if exists('$TERM_PROGRAM') && $TERM_PROGRAM ==# 'iTerm.app'
    let g:altmeta_delay = 300
endif

so ~/code/cloned/vim/vim/init.vim
so ~/code/cloned/vim/vim/skywind.vim

let g:bundle_home = '~/code/cloned/vim/bundles_skywind'
let g:bundle_group = ['simple', 'basic', 'inter', 'high', 'opt', 'ale', 'echodoc', 'nerdtree', 'lsp']
so ~/code/cloned/vim/vim/bundle.vim

