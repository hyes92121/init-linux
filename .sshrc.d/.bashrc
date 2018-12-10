#report_err() {
#    echo "errexit on line $(caller)" >&2
#}
#trap report_err ERR

source $SSHHOME/.sshrc.d/.bash-powerline.sh
#source ~/twoline_prompt.sh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

alias ls='ls -l --color=auto'
alias cls='clear'
alias rm='rm -i'
alias ssh='sshrc -XY'
alias python='python3.6'
alias sublime='open /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias ptt='ssh bbsu@ptt.cc'
alias sl='sl -claF'

yoctol='r444b.ee.ntu.edu.tw'
TORCH_ENV='~/Environments/torch/bin/activate'


# added by Miniconda installer
# need this in /.sshrc.d/.bashrc because sshrc uses custom .bashrc instead of
# native .bashrc
export PATH="/home/hyes92121/miniconda3/bin:$PATH"


transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi 
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile; fi; cat $tmpfile; echo " "; rm -f $tmpfile;} 

export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${CUDA_HOME}/lib64
PATH=${CUDA_HOME}/bin:${PATH}
export PATH
