source $SSHHOME/.sshrc.d/.bash-powerline.sh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

alias l='ls'
alias ls='ls -l --color=auto'
alias rm='rm -i'
alias ssh='sshrc -XY'

# show only two layers of the current directory
export PROMPT_DIRTRIM=2



# setup GOPATH
# by default GOPATH is set to $HOME/go
export GOPATH=/Users/caleb/go/
# setup GOBIN
export GOBIN=$GOPATH/bin
# add GOPATH and GOBIN to system PATH
export PATH=$PATH:$GOPATH:$GOBIN

