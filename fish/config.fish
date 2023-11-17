if status is-interactive
    # Commands to run in interactive sessions can go here
    alias lg = 'lazygit'
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if uname | grep -q Linux
    if test -f /home/zwyyy/miniconda3/bin/conda
        eval /home/zwyyy/miniconda3/bin/conda "shell.fish" hook $argv | source
    end
    # <<< conda initialize <<<
    set -gx GOPATH $HOME/go
    set -gx PATH $GOPATH/bin $PATH
    set -gx PATH /opt/riscv/bin $PATH

end

if uname | grep -q Darwin
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
        eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" hook $argv | source
    end
    # <<< conda initialize <<<

    # set path
    set -x PATH /opt/homebrew/bin $PATH
    set -x PATH /opt/homebrew/opt/postgresql@15/bin $PATH
end
