cd ~ 

# Backup original user files
need_backup=false
mkdir .env_backup
if [ -f .bashrc ]; then
    echo .bashrc exists. Moving to backup...
    mv .bashrc .env_backup
    need_backup=true;
fi 
if [ -f .vimrc ]; then
    echo .vimrc exists. Moving to backup...
    mv .vimrc .env_backup
    need_backup=true
fi
if [ -d .vim ]; then
    echo .vim exists. Moving to backup...
    mv .vim .env_backup
    need_backup=true
fi
# Delete environment backup if not needed
if [ "$need_backup" = false ]; then
    echo Deleting original user files
    rm -rf .env_backup
fi

# move files to home directory
mv init-linux/.bash* .
mv init-linux/.vim* .
cd .vim/
mkdir bundle; cd bundle
git clone https://github.com/nanotech/jellybeans.vim
git clone https://github.com/vim-airline/vim-airline
cd ~
rm -rf init-linux 



case "$(uname)" in
    Darwin)   echo "source ~/.bashrc" > .bash_profile;; # macOS runs .bash_profile on shell startup
esac

source ~/.bashrc
echo Finish setting up bash and vim env. 

case "$(uname)" in
    Darwin)   
        if [ -z $(which wget) ]; then 
            echo wget not found. Installing wget...
            brew install wget
        fi
        MINICONDA_URL='https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh'
        MINICONDA_SCRIPT='Miniconda3-latest-MacOSX-x86_64.sh'
        ;;
    Linux)
        if [ -z $(which wget) ]; then 
            echo wget not found. Installing wget...
            sudo apt install wget
        fi
        sudo apt install wget
        MINICONDA_URL='https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh'
        MINICONDA_SCRIPT='Miniconda3-latest-Linux-x86_64.sh'
        ;;
esac
echo Done!
wget $MINICONDA_URL
sh $MINICONDA_SCRIPT
