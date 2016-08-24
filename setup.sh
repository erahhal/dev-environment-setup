#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd )"

#-------------------------------------------------------------
# Bash
#-------------------------------------------------------------

if [ "$DIR/Scripts" != "$(ls -l ~/Scripts | awk '{print $11}')" ]; then
  mv ~/Scripts ~/Scripts.orig
  ln -s $DIR/Scripts ~/Scripts
fi
if [ "$DIR/bash/bashrc" != "$(ls -l ~/.bashrc | awk '{print $11}')" ]; then
  mv ~/.bashrc ~/.bashrc.orig
  ln -s $DIR/bash/bashrc ~/.bashrc
fi
if [ "$DIR/bash/xsessionrc" != "$(ls -l ~/.xsessionrc | awk '{print $11}')" ]; then
  mv ~/.xsessionrc ~/.xsessionrc.orig
  ln -s $DIR/bash/xsessionrc ~/.xsessionrc
fi
if [ "$DIR/bash/bash_profile" != "$(ls -l ~/.bash_profile | awk '{print $11}')" ]; then
  mv ~/.bash_profile ~/.bash_profile.orig
  ln -s $DIR/bash/bash_profile ~/.bash_profile
fi
if [ "$DIR/bash/screenrc" != "$(ls -l ~/.screenrc | awk '{print $11}')" ]; then
  mv ~/.screenrc ~/.screenrc.orig
  ln -s $DIR/bash/screenrc ~/.screenrc
fi
if [ "$DIR/bash/tmux.conf" != "$(ls -l ~/.tmux.conf | awk '{print $11}')" ]; then
  mv ~/.tmux.conf ~/.tmux.conf.orig
  ln -s $DIR/bash/tmux.conf ~/.tmux.conf
fi

#-------------------------------------------------------------
# 3rd party code
#-------------------------------------------------------------

mkdir -p ~/Code-vendor

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
$NODE_SUDO npm install -g eslint
$NODE_SUDO npm install -g eslint-plugin-html

#-------------------------------------------------------------
# VIM
#-------------------------------------------------------------

if [ "$DIR/vim/vimrc" != "$(ls -l ~/.vimrc | awk '{print $11}')" ]; then
  mv ~/.vimrc ~/.vimrc.orig
  ln -s $DIR/vim/vimrc ~/.vimrc
fi
mkdir -p ~/.vim
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
if [ "~/.vim" != "$(ls -l ~/.config/nvim | awk '{print $11}')" ]; then
  mv ~/.config/nvim ~/.config/nvim.orig
  ln -s ~/.vim ~/.config/nvim
fi
if [ "$DIR/vim/vimrc" != "$(ls -l ~/.config/nvim/init.vim | awk '{print $11}')" ]; then
  mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.orig
  ln -s $DIR/vim/vimrc ~/.config/nvim/init.vim
fi
if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim -c "execute 'BundleInstall' | qa"
cp -R ~/.vim/bundle/vim-colors-solarized/colors ~/.vim
if [ "$DIR/vim/ycm_extra_conf.py" != "$(ls -l ~/.ycm_extra_conf.py | awk '{print $11}')" ]; then
  mv ~/.ycm_extra_conf.py ~/.ycm_extra_conf.py.orig
  ln -s $DIR/vim/ycm_extr_conf.py ~/.ycm_extra_conf.py
fi

cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
if [ "$(uname)" == "Darwin" ]; then
  cd third_party/ycmd
  cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=/usr/bin -DPYTHON_INCLUDE_DIR=/usr/local/Frameworks/Python.framework/Headers -DPYTHON_LIBRARY=/usr/local/Frameworks/Python.framework/Python . ./cpp
  /usr/local/bin/python ./build.py --clang-completer --omnisharp-completer --gocode-completer
else
  ./install.py --clang-completer --gocode-completer
fi

cd ~/.vim/bundle/tern_for_vim
npm install
sudo npm install -g
cd ~/.vim/bundle/Command-T/ruby/command-t/
ruby extconf.rb
make

#-------------------------------------------------------------
# Emacs
#-------------------------------------------------------------

cd ~/
if [ ! -e .spacemacs ]; then
  if [ -e .emacs.d ]; then
    mv .emacs.d .emacs.d.orig
  fi
  git clone --recursive http://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

#-------------------------------------------------------------
# IRSSI
#-------------------------------------------------------------

if [ "$DIR/irssi" != "$(ls -l ~/.irssi | awk '{print $11}')" ]; then
  mv ~/.irssi ~/.irssi.orig
  ln -s $DIR/irssi ~/.irssi
fi
