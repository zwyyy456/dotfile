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

if test -d $HOME/.loca/bin
    fish_add_path $HOME/.local/bin # global default
end

if not set -q MANPATH
    set -gx MANPATH (manpath) ~/.config/tool-man
else
    set -gx MANPATH $MANPATH ~/.config/tool-man
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
