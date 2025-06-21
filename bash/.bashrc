# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
eval "$(dircolors)"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

pathadd() {
    case ":${PATH}:" in
    *:"$1":*) ;;
    *)
        if [ "$2" = "after" ]; then
            PATH=$PATH:$1
        else
            PATH=$1:$PATH
        fi
        ;;
    esac
}
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/.local/miniconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/.local/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/.local/miniconda3/etc/profile.d/conda.sh"
    else
        pathadd $HOME/.local/miniconda3/bin
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

pathadd $HOME/.local/bin after
pathadd $HOME/.local/bin after

if [[ -d "$HOME/.local/go/bin" ]]; then
    pathadd $HOME/.local/go/bin after
fi

if [[ -f "$HOME/.local/cargo/env" ]]; then
    . $HOME/.local/cargo/env
fi

if [[ -f "$HOME/go/bin" ]]; then
    pathadd $HOME/go/bin
fi
export PATH
