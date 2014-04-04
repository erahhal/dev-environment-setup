#!/bin/sh
                               
DIR="$( cd "$( dirname "$0" )" && pwd )"

mkdir -p ~/.vim                
cp $DIR/vim/vimrc ~/.vimrc     
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim -c "execute 'BundleInstall' | qa"
cp -R ~/.vim/bundle/vim-colors-solarized/colors ~/.vim

