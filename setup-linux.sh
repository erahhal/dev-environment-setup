#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

#-------------------------------------------------------------
# Linux
#-------------------------------------------------------------

arch=`uname -m`
if [[ "$arch" == "i686" ]]; then
  echo "Linux i686"
elif [[ "$arch" == "x86_64" ]]; then
  echo "Linux x86_64"
else
  # Unknown architecture
  echo "Unknown architecture"
  exit 1
fi

if hash apt-get 2>/dev/null; then
  . /etc/lsb-release
  # getdeb
  URL='http://archive.getdeb.net/install_deb/getdeb-repository_0.1-1~getdeb1_all.deb'; FILE=`mktemp`; wget "$URL" -qO $FILE && sudo dpkg -i $FILE; rm $FILE
  sudo rm /etc/apt/sources.list.d/getdeb.list.bck
  # Emacs
  sudo add-apt-repository -y ppa:ubuntu-elisp/ppa
  # What is this?
  sudo add-apt-repository -y ppa:fcwu-tw/ppa
  # java
  sudo add-apt-repository -y ppa:webupd8team/java
  # xmonad
  sudo add-apt-repository -y ppa:gekkio/xmonad
  # Neovim
  sudo add-apt-repository -y ppa:neovim-ppa/unstable
  # Keepass
  sudo add-apt-repository -y ppa:jtaylor/keepass
  sudo apt-get update
  sudo apt-get install -y software-properties-common python-software-properties vim postgresql nginx cmake python-dev cmake nodejs gocode golang-go gccgo ack-grep vim xclip x11-xserver-utils python-dev python-pip python-pkg-resources python-setuptools cmake xclip ack-grep emacs-snapshot mosh tmux ibus-sunpinyin chromium-browser keepass2 language-pack-zh-hans `check-language-support -l zh-hans`
  sudo apt-get install -y choqok
  sudo apt-get install -y neovim
  sudo apt-get install -y cscope
  sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
  sudo update-alternatives --set vi /usr/bin/nvim
  sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
  sudo update-alternatives --set vim /usr/bin/nvim
  sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
  sudo update-alternatives --set editor /usr/bin/nvim
  sudo pip2 install neovim
  sudo pip2 install simplejson
  sudo apt-get install -y oracle-java7-installer
  sudo apt-get install -y xmonad*
  sudo apt-get install -y suckless-tools xscreensaver xmobar scrot xfce4-power-manager stalonetray dmenu cabal-install
  sudo cabal update
  sudo cabal install --global yeganesh
  sudo apt-get install -y xscreensaver xscreensaver-gl-extra xscreensaver-data-extra xfishtank xdaliclock fortune
elif hash yum 2>/dev/null; then
  sudo yum install -y ack
else
  echo "Unknown distribution"
  exit 1
fi

cd ~/Code-vendor
git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
cd gnome-terminal-colors-solarized
./set_dark.sh

cd ~/Code-vendor
git clone https://github.com/sgerrand/xfce4-terminal-colors-solarized.git
cd xfce4-terminal-colors-solarized
mkdir -p ~/.config/Terminal
cp dark/terminalrc ~/.config/Terminal
mkdir -p ~/.config/xfce4/terminal
cp dark/terminalrc ~/.config/xfce4/terminal

if [ "$(readlink ~/.xmonad)" != "$DIR/xmonad" ]; then
  if [ -d "~/.xmonad" ]; then
    mv ~/.xmonad ~/.xmonad.orig
  fi
  ln -s $DIR/xmonad ~/.xmonad
fi

if [ "$(readlink ~/.stalonetrayrc)" != "$DIR/xmonad/stalonetrayrc" ]; then
  mv ~/.stalonetrayrc ~/.stalonetrayrc.orig
  ln -s $DIR/xmonad/stalonetrayrc ~/.stalonetrayrc
fi

if [ "$(readlink ~/.xscreensaver)" != "$DIR/xscreensaver/xscreensaver" ]; then
  mv ~/.xscreensaver ~/.xscreensaver.orig
  ln -s $DIR/xscreensaver/xscreensaver ~/.xscreensaver
fi
