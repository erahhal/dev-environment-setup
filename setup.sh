#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd )"

#-------------------------------------------------------------
# Scripts to get real path of a file
#-------------------------------------------------------------

realpath() {
    canonicalize_path "$(resolve_symlinks "$1")"
}

resolve_symlinks() {
    local dir_context path
    path=$(readlink -- "$1")
    if [ $? -eq 0 ]; then
        dir_context=$(dirname -- "$1")
        resolve_symlinks "$(_prepend_path_if_relative "$dir_context" "$path")"
    else
        printf '%s\n' "$1"
    fi
}

_prepend_path_if_relative() {
    case "$2" in
        /* ) printf '%s\n' "$2" ;;
         * ) printf '%s\n' "$1/$2" ;;
    esac
}

canonicalize_path() {
    if [ -d "$1" ]; then
        _canonicalize_dir_path "$1"
    else
        _canonicalize_file_path "$1"
    fi
}

_canonicalize_dir_path() {
    (cd "$1" 2>/dev/null && pwd -P)
}

_canonicalize_file_path() {
    local dir file
    dir=$(dirname -- "$1")
    file=$(basename -- "$1")
    (cd "$dir" 2>/dev/null && printf '%s/%s\n' "$(pwd -P)" "$file")
}

#-------------------------------------------------------------
# Bash
#-------------------------------------------------------------

if [ $(realpath "$DIR/Scripts") != $(realpath ~/Scripts) ]; then
  mv ~/Scripts ~/Scripts.orig
  ln -s $DIR/Scripts ~/Scripts
fi
if [ $(realpath "$DIR/bash/bashrc") != $(realpath ~/.bashrc) ]; then
  mv ~/.bashrc ~/.bashrc.orig
  ln -s $DIR/bash/bashrc ~/.bashrc
fi
if [ $(realpath "$DIR/bash/xsessionrc") != $(realpath ~/.xsessionrc) ]; then
  mv ~/.xsessionrc ~/.xsessionrc.orig
  ln -s $DIR/bash/xsessionrc ~/.xsessionrc
fi
if [ $(realpath "$DIR/bash/bash_profile") != $(realpath ~/.bash_profile) ]; then
  mv ~/.bash_profile ~/.bash_profile.orig
  ln -s $DIR/bash/bash_profile ~/.bash_profile
fi
if [ $(realpath "$DIR/bash/bash_profile") != $(realpath ~/.profile) ]; then
  mv ~/.profile ~/.profile.orig
  ln -s $DIR/bash/bash_profile ~/.profile
fi
if [ $(realpath "$DIR/bash/screenrc") != $(realpath ~/.screenrc) ]; then
  mv ~/.screenrc ~/.screenrc.orig
  ln -s $DIR/bash/screenrc ~/.screenrc
fi
if [ $(realpath "$DIR/bash/tmux.conf") != $(realpath ~/.tmux.conf) ]; then
  mv ~/.tmux.conf ~/.tmux.conf.orig
  ln -s $DIR/bash/tmux.conf ~/.tmux.conf
fi
if [ ! -e ~/.tmux-plugins ]; then
  mkdir ~/.tmux-plugins
fi

cd ~/.tmux-plugins
if [ ! -e tpm ]; then
    git clone https://github.com/tmux-plugins/tpm
fi
if [ ! -e tmux-sensible ]; then
    git clone https://github.com/tmux-plugins/tmux-sensible
fi
if [ ! -e tmux-resurrect ]; then
    git clone https://github.com/tmux-plugins/tmux-resurrect
fi
if [ ! -e tmux-open ]; then
    git clone https://github.com/tmux-plugins/tmux-open
fi

#-------------------------------------------------------------
# 3rd party code
#-------------------------------------------------------------

mkdir -p ~/Code-vendor
mkdir -p ~/go

#-------------------------------------------------------------
# Platform specific
#-------------------------------------------------------------

if [ "$(uname)" == "Darwin" ]; then
  $DIR/setup-osx.sh
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  $DIR/setup-linux.sh
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
  #-------------------------------------------------------------
  # Cygwin
  #-------------------------------------------------------------
  echo "Cygwin"
else
  # Unknown platform
  echo "Unknown platform"
fi

#-------------------------------------------------------------
# Node
#-------------------------------------------------------------

if [ "$(uname)" == "Darwin" ]; then
  NODE_SUDO=""
else
  NODE_SUDO="sudo"
fi

$NODE_SUDO npm install -g bower
$NODE_SUDO npm install -g grunt-cli
$NODE_SUDO npm install -g tern
$NODE_SUDO npm install -g eslint
$NODE_SUDO npm install -g eslint-plugin-html
# Needed for tagbar in vim, but currently broken
# $NODE_SUDO npm install -g jsctags

#-------------------------------------------------------------
# git
#-------------------------------------------------------------

git config --global merge.tool vimdiff
git config --global merge.conflictstyle diff3
git config --global mergetool.prompt false

#-------------------------------------------------------------
# VIM
#-------------------------------------------------------------

if [ $(realpath "$DIR/vim/vimrc") != $(realpath ~/.vimrc) ]; then
  mv ~/.vimrc ~/.vimrc.orig
  ln -s $DIR/vim/vimrc ~/.vimrc
fi
mkdir -p ~/.vim
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
if [ $(realpath ~/.vim) != $(realpath ~/.config/nvim) ]; then
  mv ~/.config/nvim ~/.config/nvim.orig
  ln -s ~/.vim ~/.config/nvim
fi
if [ $(realpath "$DIR/vim/vimrc") != $(realpath ~/.config/nvim/init.vim) ]; then
  mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.orig
  ln -s $DIR/vim/vimrc ~/.config/nvim/init.vim
fi
if [ ! -e ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
vim -c "execute 'PlugInstall' | qa"
vim -c "execute 'UpdateRemotePlugins' | qa"
cp -R ~/.vim/bundle/vim-colors-solarized/colors ~/.vim
if [ $(realpath "$DIR/vim/ycm_extra_conf.py") != $(realpath ~/.ycm_extra_conf.py) ]; then
  mv ~/.ycm_extra_conf.py ~/.ycm_extra_conf.py.orig
  ln -s $DIR/vim/ycm_extr_conf.py ~/.ycm_extra_conf.py
fi

$DIR/vim/ycm-update.sh

# Build Shougo/vimproc.vim
cd ~/.vim/bundle/vimproc.vim
make

cd ~/.vim/bundle/tern_for_vim
npm install
sudo npm install -g
## Now using command-p, but leaving this for posterity
# cd ~/.vim/bundle/Command-T/ruby/command-t/
# ruby extconf.rb
# make

#-------------------------------------------------------------
# Emacs
#-------------------------------------------------------------

if [ ! -e ~/.spacemacs ]; then
  if [ ! -e ~/.emacs.d ]; then
    NO_EMACS_CONF=1
  elif ! git -C ~/.emacs.d rev-parse; then
    NO_EMACS_CONF=1
    mv .emacs.d .emacs.d.orig
  fi
  if [ "$NO_EMACS_CONF" == 1 ]; then
    git clone --recursive http://github.com/syl20bnr/spacemacs ~/.emacs.d
  fi
fi

#-------------------------------------------------------------
# IRSSI
#-------------------------------------------------------------

if [ $(realpath "$DIR/irssi") != $(realpath ~/.irssi) ]; then
  mv ~/.irssi ~/.irssi.orig
  ln -s $DIR/irssi ~/.irssi
fi

#-------------------------------------------------------------
# Google Cloud SDK
#-------------------------------------------------------------

gcloud container clusters get-credentials ellis-cluster
