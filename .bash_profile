source ~/.bashrc


# add mysql to $PATH
export PATH=${PATH}:/usr/local/mysql/bin/

# add /sbin to $PATH
export PATH=${PATH}:/sbin/

# add /usr/sbin to $PATH
export PATH=${PATH}:/usr/sbin

# add pyenv
#export PATH=${PATH}:/home/caspian/.pyenv/bin
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"


export LSCOLORS="ExfxcxdxBxegecabagacad"

# added by Miniconda3 installer
export PATH="/Users/$(whoami)/miniconda3/bin:$PATH"
. /Users/$(whoami)/miniconda3/etc/profile.d/conda.sh
