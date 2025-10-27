# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# export PATH=.:$PATH
# BASEPATH=$HOME/rms_run

export ORACLE_HOME=$HOME/oracle_linux_instantclient_11_2
# export PATH=$PATH:$ORACLE_HOME:$ORACLE_HOME/bin:.
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME:$ORACLE_HOME/lib:/lib:/usr/lib:$ORACLE_HOME/rdbms/lib:$BASEPATH/commlib
export TERM="xterm-256color"
export TNS_ADMIN=$ORACLE_HOME
export SHLIB_PATH=$ORACLE_HOME:$ORACLE_HOME/lib:$ORACLE_HOME/rdbms/lib
export NLS_LANG=american_america.zhs16gbk
export NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS'
# User specific aliases and functions
export PATH=$(echo -n "$PATH" | tr ':' '\n' | awk '!seen[$0]++' | paste -sd: -)
export LD_LIBRARY_PATH=$(echo -n "$LD_LIBRARY_PATH" | tr ':' '\n' | awk '!seen[$0]++' | paste -sd: -)
envmunge() {
    local tar_var="$1"
    local new_var="$2"
    local pos="${3:-before}"
    local sep="${4:-:}"
    local cur_var="${!tar_var:-}"

    case "${sep}${cur_var}${sep}" in
    *"${sep}${new_var}${sep}"*) ;;
    *)
        if [ "$pos" == "after" ]; then
            cur_var="${cur_var:+${cur_var}${sep}}${new_var}"
        else
            cur_var="${new_var}${cur_var:+${sep}${cur_var}}"
        fi
        ;;
    esac
    export "$tar_var"="$cur_var"
}
envmunge PATH $ORACLE_HOME after
envmunge PATH $ORACLE_HOME/bin after
envmunge PATH /devprog/bin
envmunge LD_LIBRARY_PATH $ORACLE_HOME after
envmunge LD_LIBRARY_PATH $ORACLE_HOME/lib after
envmunge LD_LIBRARY_PATH $ORACLE_HOME/rdbms/lib after
envmunge LD_LIBRARY_PATH $HOME/commlib

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/cffex/zengwy/.local/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/cffex/zengwy/.local/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/cffex/zengwy/.local/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/cffex/zengwy/.local/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

