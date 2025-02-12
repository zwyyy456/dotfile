#!/bin/zsh

##
# Environment variables
#

# -U ensures each entry in these is unique (that is, discards duplicates).
export -U PATH path FPATH fpath MANPATH manpath
export -UT INFOPATH infopath  # -T creates a "tied" pair; see below.

# $PATH and $path (and also $FPATH and $fpath, etc.) are "tied" to each other.
# Modifying one will also modify the other.
# Note that each value in an array is expanded separately. Thus, we can use ~
# for $HOME in each $path entry.
path=(
    /home/linuxbrew/.linuxbrew/bin(N)   # (N): null if file doesn't exist
    $path
    ~/.local/bin
    /devprog/bin(N)
    /devdata/bin(N)
)

# Add your functions to your $fpath, so you can autoload them.
fpath=(
    $ZDOTDIR/functions
    $fpath
    ~/.local/share/zsh/site-functions
)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#bcbcbc,bg=#444444,underline"
autoload -Uz zvm_config

if command -v /opt/homebrew/bin/brew > /dev/null; then
  # `znap eval <name> '<command>'` is like `eval "$( <command> )"` but with
  # caching and compilation of <command>'s output, making it 10 times faster.
  znap eval brew-shellenv '/opt/homebrew/bin/brew shellenv'

  # Add dirs containing completion functions to your $fpath and they will be
  # picked up automatically when the completion system is initialized.
  # Here, we add it to the end of $fpath, so that we use brew's completions
  # only for those commands that zsh doesn't already know how to complete.
  fpath+=(
      $HOMEBREW_PREFIX/share/zsh/site-functions
  )
  # Set PATH, MANPATH, etc., for Homebrew.
  export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
  export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"

  if [[ -f $HOMEBREW_PREFIX/bin/conda ]]; then
      znap eval conda-init "$HOMEBREW_PREFIX/bin/conda 'shell.zsh' hook $argv"
  fi
fi


# Added by OrbStack: command-line tools and integration
# Comment this line if you don't want it to be added again.
if [ -f ~/.orbstack/shell/init.zsh ]; then
   . ~/.orbstack/shell/init.zsh 2>/dev/null || :
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if [[ -f /devprog/miniconda3/bin/conda ]]; then
    __conda_setup="$(/devprog/miniconda3/bin/conda 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup" # conda 的设置需要直接修改当前 shell 的环境内容，无法使用 znap 缓存加速
    fi
    unset __conda_setup
fi
# <<< conda initialize <<<
