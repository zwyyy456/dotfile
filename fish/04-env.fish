# color for hydro

set -g hydro_color_pwd green
set -g hydro_color_git brmagenta


# set hombrew
if test -f /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
    # set homebrew source
    set -g HOMEBREW_BREW_GIT_REMOTE "https://mirrors.ustc.edu.cn/brew.git"
    set -g HOMEBREW_BOTTLE_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles"
    set -g HOMEBREW_API_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles/api"
    if test -f $HOMEBREW_PREFIX/bin/conda
        eval $HOMEBREW_PREFIX/bin/conda "shell.fish" hook $argv | source
    end
end

if test -d /devprog/bin
    fish_add_path /devprog/bin # global default
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f $HOME/miniconda3/bin/conda
    eval $HOME/miniconda3/bin/conda "shell.fish" hook $argv | source
end
# <<< conda initialize <<<