# color for hydro

set -gx hydro_color_pwd green
set -gx hydro_color_git brmagenta

# set hombrew
if test -f /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
    # set homebrew source
    set -gx HOMEBREW_BREW_GIT_REMOTE "https://mirrors.ustc.edu.cn/brew.git"
    set -gx HOMEBREW_BOTTLE_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles"
    set -gx HOMEBREW_API_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles/api"
    if test -f $HOMEBREW_PREFIX/bin/conda
        eval $HOMEBREW_PREFIX/bin/conda "shell.fish" hook $argv | source
    end
end

if test -d $HOME/.local/bin
    fish_add_path $HOME/.local/bin # global default
end

if test -d /devprog/bin
    fish_add_path /devprog/bin # global default
end

if test -d $HOME/.local/go/bin
    fish_add_path $HOME/.local/go/bin # global default
end

if test -d $HOME/go/bin
    fish_add_path $HOME/go/bin # global default
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f $HOME/.local/miniconda3/bin/conda
    eval $HOME/.local/miniconda3/bin/conda "shell.fish" hook $argv | source
end
# <<< conda initialize <<<

if test -f $HOME/.cargo/env.fish
    source "$HOME/.cargo/env.fish"
end

# deduplicate
deduplicate_var PATH
deduplicate_var MANPATH
deduplicate_var LD_LIBRARY_PATH
deduplicate_var LIBRARY_PATH

set fish_color_autosuggestion brwhite --dim --underline

if test -d /devprog/autocomplete
    set -g -a fish_complete_path /devprog/autocomplete
end
