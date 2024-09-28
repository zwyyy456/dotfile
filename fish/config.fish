if status is-interactive
    # Commands to run in interactive sessions can go here
    alias lg lazygit
end


if uname | grep -q Linux
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    if test -f /home/zwyyy/miniconda3/bin/conda
        eval /home/zwyyy/miniconda3/bin/conda "shell.fish" hook $argv | source
    else if test -f /root/miniconda3/bin/conda
        eval /root/miniconda3/bin/conda "shell.fish" hook & argv | source
    end
    # <<< conda initialize <<<
    set -gx GOPATH $HOME/go
    set -gx PATH  $PATH $HOME/.local/bin $GOPATH/bin
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
    # command-line-tools 够了，不需要额外安装 llvm，反而容易出问题s
    #set -gx PATH /opt/homebrew/opt/llvm/bin $PATH
    #set -gx LDFLAGS -L/opt/homebrew/opt/llvm/lib
    #set -gx CPPFLAGS -I/opt/homebrew/opt/llvm/include

end
