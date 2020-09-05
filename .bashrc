source ~/.bash-powerline.sh
PROMPT_DIRTRIM=2 # needs bash version > 3

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

case "$(uname)" in
    Darwin) alias ls='ls -FGhn';; 
    Linux)  alias ls='ls -l --color=auto';;
esac
alias rm='rm -i' # confirm beform deleting files 
alias ssh='ssh -XY -o ServerAliveInterval=180' # send signal to ssh server every 180 seconds to prevent disconnecting
