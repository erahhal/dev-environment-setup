#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

#-------------------------------------------------------------
# Linux
#-------------------------------------------------------------

. /etc/os-release

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
    sudo apt-get install -y curl
    . /etc/lsb-release

    # # getdeb
    # URL='http://archive.getdeb.net/install_deb/getdeb-repository_0.1-1~getdeb1_all.deb'; FILE=`mktemp`; wget "$URL" -qO $FILE && sudo dpkg -i $FILE; rm $FILE
    # sudo rm /etc/apt/sources.list.d/getdeb.list.bck

    # # Emacs
    # sudo add-apt-repository -y ppa:ubuntu-elisp/ppa

    # # What is this?
    # sudo add-apt-repository -y ppa:fcwu-tw/ppa

    # diffmerge
    echo "deb http://debian.sourcegear.com/ubuntu precise main" | sudo tee /etc/apt/sources.list.d/sourcegear.list
    sudo wget -O - http://debian.sourcegear.com/SOURCEGEAR-GPG-KEY | sudo apt-key add -

    # xpra (used to scale lo-res apps to hidpi
    sudo wget -O - https://winswitch.org/gpg.asc | sudo apt-key add -
    echo "deb http://winswitch.org/ $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/winswitch.list;

    # java
    sudo add-apt-repository -y ppa:webupd8team/java

    # # xmonad
    # sudo add-apt-repository -y ppa:gekkio/xmonad

    # Neovim
    sudo add-apt-repository -y ppa:neovim-ppa/stable

    # # Keepass
    # sudo add-apt-repository -y ppa:jtaylor/keepass

    # Caffeine
    sudo add-apt-repository -y ppa:caffeine-developers/ppa

    # Gnome Xmonad session
    sudo add-apt-repository -y ppa:gekkio/xmonad

    # VSCode
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

    # VIM 8
    sudo apt-add-repository -y ppa:jonathonf/vim

    # Syncthing
    curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
    echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

    # Add the Spotify repository signing keys to be able to verify downloaded packages
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410

    # Add the Spotify repository
    echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
    # Bazel
    echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
    curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -

    # nodejs
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
    sudo apt-get install -y nodejs

    #ripgrep
    # sudo add-apt-repository -y ppa:x4121/ripgrep
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys A03A097E3C3842E1
    echo "deb http://ppa.launchpad.net/x4121/ripgrep/ubuntu zesty main" | sudo tee /etc/apt/sources.list.d/ripgrep.list

    sudo apt-get update
    sudo apt-get install -y software-properties-common python-software-properties vim vim-scripts vim-doc vim-gtk-py2 vim-gtk3-py2 vim-addon-manager vim-nox-py2 postgresql nginx cmake python-dev cmake nodejs syncthing syncthing-inotify code gocode golang-go gccgo ack-grep silversearcher-ag ripgrep xclip x11-xserver-utils python-dev python-pip python3-pip python-pkg-resources python-setuptools pylint pep8 ruby ruby-dev cmake xclip ack-grep mosh tmux ibus-sunpinyin chromium-browser gnome-session-xmonad gnome-terminal gnome-tweak-tool spotify-client g++ libstdc++6 caffeine redshift redshift-gtk keepass2 exuberant-ctags language-pack-zh-hans `check-language-support -l zh-hans`

    # sudo apt-get install -y emacs-snapshot

    # # Installing xubuntu causes hwe (hardware enablement) versions of xorg to be removed...
    # sudo apt-get install -y xubuntu-desktop
    # sudo apt remove --purge -y ubuntu-desktop

    # Google pinyin input
    sudo apt-get install -y fcitx fcitx-googlepinyin fcitx-table-wbpy fcitx-pinyin fcitx-sunpinyin
    sudo apt-get install -y choqok
    sudo apt-get install -y neovim
    sudo apt-get install -y clang
    sudo apt-get install -y clang-3.9
    # For vim
    sudo apt-get install -y libclang-3.9
    sudo apt-get install -y clang-format
    sudo apt-get install -y llvm
    sudo apt-get install -y lldb
    sudo apt-get install -y bazel
    # To build html5-tidy man page
    sudo apt-get install -y xsltproc
    # Remove bottom bar from gnome xmonad session
    dconf write /org/gnome/gnome-panel/layout/toplevel-id-list "['top-panel']"
    # To re-display bottom bar, use:
    # dconf write /org/gnome/gnome-panel/layout/toplevel-id-list "['top-panel','bottom-panel']"

    # Fix lldb symlinks
    sudo ln -sf /usr/lib/x86_64-linux-gnu/libLLVM-3.8.so.1 /usr/lib/python2.7/dist-packages/lldb/libLLVM-3.8.0.so.1
    sudo ln -sf /usr/lib/x86_64-linux-gnu/libLLVM-3.8.so.1 /usr/lib/python2.7/dist-packages/lldb/libLLVM-3.8.so.1
    sudo ln -sf /usr/lib/llvm-3.8/lib/liblldb.so.1 /usr/lib/python2.7/dist-packages/lldb/_lldb.so
    sudo apt-get install -y cscope
    sudo apt-get install -y ccache
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --set vi /usr/bin/nvim
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    sudo update-alternatives --set vim /usr/bin/nvim
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
    sudo update-alternatives --set editor /usr/bin/nvim
    sudo update-alternatives --set vimdiff /usr/bin/vim.nox-py2
    sudo pip3 install --upgrade pip
    sudo pip2 install --upgrade pip
    sudo pip2 install --upgrade neovim
    sudo pip3 install --upgrade neovim
    sudo pip2 install --upgrade simplejson
    sudo pip2 install --upgrade pytz
    sudo pip2 install --upgrade requests_futures
    sudo gem install neovim
    sudo apt-get install -y oracle-java8-installer
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

# Android
sudo add-apt-repository -y ppa:paolorotolo/android-studio
sudo apt-get update -y
sudo apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
sudo apt-get install -y android-tools-adb

# lib fix for building Unreal editor
sudo ln -sf /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/lib/x86_64-linux-gnu/libstdc++.so

# fonts
$DIR/fonts/install.sh

# Syncthing
systemctl --user enable syncthing.service
systemctl --user start syncthing.service

if [ ! -d "$HOME/google-cloud-sdk/" ]; then
  # Google Cloud SDK
  curl https://sdk.cloud.google.com | bash
  bash -c 'gcloud init; gcloud components install kubectl container-builder-local docker-credential-gcr'
fi

# Placurl https://sdk.cloud.google.com | bashtformIO
if ! hash platformio 2>/dev/null; then
    python -c "$(curl -fsSL https://raw.githubusercontent.com/platformio/platformio/develop/scripts/get-platformio.py)"
fi

cd ~/Code-vendor

if [ ! -d "xwindows-solarized" ]; then
    git clone https://github.com/solarized/xresources.git xwindows-solarized
fi
if [ ! -d "gnome-terminal-colors-solarized" ]; then
    git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
    cd gnome-terminal-colors-solarized
    ./set_dark.sh
    cd ..
fi

if [ ! -d "xfce4-terminal-colors-solarized" ]; then
    git clone https://github.com/sgerrand/xfce4-terminal-colors-solarized.git
    cd xfce4-terminal-colors-solarized
    mkdir -p ~/.config/Terminal
    cp dark/terminalrc ~/.config/Terminal
    mkdir -p ~/.config/xfce4/terminal
    cp dark/terminalrc ~/.config/xfce4/terminal
    cd ..
fi

if [ ! -d "gimp-hidpi" ]; then
    git clone https://github.com/jedireza/gimp-hidpi.git
    mkdir -p ~/.gimp-2.8/themes
    cp -R gimp-hidpi ~/.gimp-2.8/themes/
fi

if [ ! -d "syncthing-ubuntu-indicator" ]; then
    git clone https://github.com/icaruseffect/syncthing-ubuntu-indicator.git
fi

if [ "$(readlink ~/.xmonad)" != "$DIR/xmonad" ]; then
  if [ -d "~/.xmonad" ]; then
    mv ~/.xmonad ~/.xmonad.orig
  fi
  ln -s $DIR/xmonad ~/.xmonad
  if [ -e ~/.xmonad/xmonad.hs.$HOSTNAME ]; then
    ln -s ~/.xmonad/xmonad.hs.$HOSTNAME ~/.xmonad/xmonad.hs
  fi
fi

# Build xmonadctl
cd ~/.xmonad
ghc --make xmonadctl.hs

if [ "$(readlink ~/.mpv)" != "$DIR/mpv" ]; then
  mv ~/.mpv ~/.mpv.orig
  ln -s $DIR/mpv ~/.mpv
fi

if [ "$(readlink ~/.stalonetrayrc)" != "$DIR/xmonad/stalonetrayrc" ]; then
  mv ~/.stalonetrayrc ~/.stalonetrayrc.orig
  ln -s $DIR/xmonad/stalonetrayrc ~/.stalonetrayrc
fi

if [ "$(readlink ~/.xscreensaver)" != "$DIR/xscreensaver/xscreensaver" ]; then
  mv ~/.xscreensaver ~/.xscreensaver.orig
  ln -s $DIR/xscreensaver/xscreensaver ~/.xscreensaver
fi

if [ "$(readlink ~/.Xresources)" != "$DIR/bash/Xresources" ]; then
  mv ~/.Xresources ~/.Xresources.orig
  ln -s $DIR/bash/Xresources ~/.Xresources
fi

# Gnome multimonitor fix
mkdir -p ~/.config/autostart
if [ "$(readlink ~/.config/autostart/update-screen-pos.desktop)" != "$DIR/gnome/update-screen-pos.desktop" ]; then
  if [ -e ~/.config/autostart/update-screen-pos.desktop ]; then
    mv ~/.config/autostart/update-screen-pos.desktop ~/.config/autostart/update-screen-pos.desktop.orig
  fi
  ln -s $DIR/gnome/update-screen-pos.desktop ~/.config/autostart/update-screen-pos.desktop
fi

# FAC (Git Fix All Conflicts)

go get github.com/mkchoi212/fac

# udev

# Add teensy board udev rules
sudo cp $DIR/udev/* /etc/udev/rules.d/
# Android rules
sudo ln -sf /lib/udev/rules.d/70-android-tools-adb.rules /etc/udev/rules.d/
sudo ln -sf $DIR/android/70-onepluse3.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo service udev restart
sudo adb kill-server
