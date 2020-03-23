#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

#-------------------------------------------------------------
# Linux
-------------------------------------------------------------

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

sudo apt-get install -y curl
. /etc/lsb-release

# diffmerge
echo "deb http://debian.sourcegear.com/ubuntu precise main" | sudo tee /etc/apt/sources.list.d/sourcegear.list
sudo wget -O - http://debian.sourcegear.com/SOURCEGEAR-GPG-KEY | sudo apt-key add -

# xpra (used to scale lo-res apps to hidpi
sudo wget -O - https://winswitch.org/gpg.asc | sudo apt-key add -
echo "deb http://winswitch.org/ $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/winswitch.list;

# Android
sudo add-apt-repository -y ppa:paolorotolo/android-studio

# Gnome Xmonad session
sudo add-apt-repository -y ppa:gekkio/xmonad

# VSCode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# VIM 8
sudo apt-add-repository -y ppa:jonathonf/vim

# Latest neovim
sudo add-apt-repository ppa:neovim-ppa/unstable

# Syncthing
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

# Spotify
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

# Bazel
echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -

# nodejs
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
sudo apt-get install -y nodejs
# delete global node_modules, as we want to use yarn instead
sudo rm -rf /usr/lib/node_modules

# eternal terminal
sudo add-apt-repoository ppa:jgmath2000/et

# yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# lsd
URL='https://github.com/Peltoche/lsd/releases/download/0.15.1/lsd_0.15.1_amd64.deb'; FILE=`mktemp`; wget "$URL" -qO $FILE && sudo dpkg -i $FILE; rm $FILE

# broot
URL='https://dystroy.org/broot/download/x86_64-linux/broot';
wget $URL
sudo mv broot /usr/local/bin/
sudo chmod +x /usr/local/bin/broot

# ripgrep
# sudo add-apt-repository -y ppa:x4121/ripgrep
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys A03A097E3C3842E1
echo "deb http://ppa.launchpad.net/x4121/ripgrep/ubuntu zesty main" | sudo tee /etc/apt/sources.list.d/ripgrep.list

# Plex
echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -

# Brave
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
source /etc/os-release
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-${UBUNTU_CODENAME}.list

sudo apt-get update

# System utilities
sudo apt-get install -y \
  ack-grep \
  autossh \
  dconf-editor \
  dialog \
  et \
  feh \
  ffmpeg \
  fuse \
  gnome-tweak-tool \
  htop \
  # Android USB file access
  jmtpfs \
  mosh \
  nginx \
  partclone \
  restic \
  ripgrep \
  # tools like add-apt-repository
  software-properties-common \
  silversearcher-ag \
  syncthing \
  tmux \
  # Contains xrandr
  x11-xserver-utils \
  xclip \
  zsh \
  zsh-syntax-highlighting

# Libraries
sudo apt-get install -y \
  gtk+-3.0 \
  gtk2.0 \
  # android dev
  lib32z1 \
  # Read mac volumes
  libattr1-dev \
  # building synergy
  libavahi-compat-libdnssd-dev \
  # android dev
  libbz2-1.0:i386 \
  # Read mac volumes
  libbz2-dev \
  # android dev
  libc6:386 \
  libclang-3.9 \
  # Read mac volumes
  libfuse-dev \
  # Read mac volumes
  libfuse3-dev \
  libgtk2.0-dev \
  # Read mac volumes
  libicu-dev \
  # android dev
  libncurses5:i386 \
  # Read mac volumes
  libfsapfs-utils \
  libstdc++6 \
  # android dev
  ibstdc++6:i386

# Programming
sudo apt-get install -y \
  android-tools-adb \
  bazel \
  build-essential \
  cabal-install \
  cargo \
  ccache \
  clang \
  clang-3.9 \
  clang-format \
  cmake \
  code \
  cpanminus \
  cscope \
  docker.io \
  exuberant-ctags \
  llvm \
  lldb \
  g++ \
  gccgo \
  ghc \
  gocode \
  golang-go \
  pep8 \
  postgresql \
  pylint \
  python-dev \
  python-pip \
  python-pkg-resources \
  python-setuptools \
  python3-pip \
  python3-pyqt5 \
  nodejs \
  oracle-java8-installer \
  ruby \
  ruby-dev \
  # To build html5-tidy man page
  xsltproc \
  yarn

# Fix lldb symlinks
sudo ln -sf /usr/lib/x86_64-linux-gnu/libLLVM-3.8.so.1 /usr/lib/python2.7/dist-packages/lldb/libLLVM-3.8.0.so.1
sudo ln -sf /usr/lib/x86_64-linux-gnu/libLLVM-3.8.so.1 /usr/lib/python2.7/dist-packages/lldb/libLLVM-3.8.so.1
sudo ln -sf /usr/lib/llvm-3.8/lib/liblldb.so.1 /usr/lib/python2.7/dist-packages/lldb/_lldb.so

# Xmonad
sudo apt-get install -y \
  gnome-session-xmonad \
  xmonad \
  xmobar \
  xcompmgr \
  suckless-tools \
  xmobar \
  scrot \
  stalonetray \
  dmenu

# Remove bottom bar from gnome xmonad session
dconf write /org/gnome/gnome-panel/layout/toplevel-id-list "['top-panel']"
# To re-display bottom bar, use:
# dconf write /org/gnome/gnome-panel/layout/toplevel-id-list "['top-panel','bottom-panel']"

# xscreensaver
sudo apt-get install -y \
  xscreensaver \
  xscreensaver-gl-extra \
  xscreensaver-data-extra \
  xfishtank \
  xdaliclock \
  fortune

# Applications
sudo apt-get install -y \
  brave-browser \
  caffeine \
  chrome-gnome-shell \
  chromium-browser \
  gimp \
  gnome-terminal \
  mpv \
  nemo \
  neovim
  plexmediaserver \
  qjackctl \
  spotify-client \
  vim \
  vim-nox-py2

# Chinese input method support
sudo apt-get install -y \
  fcitx \
  fcitx-googlepinyin \
  fcitx-table-wbpy \
  fcitx-pinyin \
  fcitx-sunpinyin \
  ibus-sunpinyin

# Chinese language support
sudo apt-get install -y \
  language-pack-zh-hans \
  `check-language-support -l zh-hans`

# Disable tap-to-click on touchpads
sudo apt-get install -y xserver-xorg-input-libinput
sudo apt-get remove --purge -y xserver-xorg-input-synaptics

# Disable gnome file indexing
sudo apt remove -y tracker tracker-extract tracker-miner-fs

# # Installing xubuntu causes hwe (hardware enablement) versions of xorg to be removed...
# sudo apt-get install -y xubuntu-desktop
# sudo apt remove --purge -y ubuntu-desktop
# sudo apt-get install -y xfce4-power-manager

if [ "$DISTRIB_CODENAME" == "xenial" ]; then
  sudo apt-get install -y redshift redshift-gtk geoclue-2.0

  # Redshift
REDSHIFT_CONFIG=$(cat <<-END
[redshift]
allowed=true
system=false
users=
END
)
  if ! grep -q "redshift" /etc/geoclue/geoclue.conf
  then
    echo "$REDSHIFT_CONFIG" | sudo tee -a /etc/geoclue/geoclue.conf
    sudo service geoclue restart
  fi
fi

# Haskell
sudo cabal update
sudo cabal install --global yeganesh

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --set vi /usr/bin/nvim
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --set vim /usr/bin/nvim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --set editor /usr/bin/nvim
sudo update-alternatives --set vimdiff /usr/bin/vim.nox-py2

# python
sudo pip3 install --upgrade pip
sudo pip2 install --upgrade pip
sudo pip2 install --upgrade flake8
sudo pip3 install --upgrade flake8
sudo pip2 install --upgrade jinja2
sudo pip3 install --upgrade jinja2
sudo pip2 install --upgrade pylint
sudo pip3 install --upgrade pylint
sudo pip2 install --upgrade msgpack
sudo pip3 install --upgrade msgpack
sudo pip2 install --upgrade neovim
sudo pip3 install --upgrade neovim
sudo pip2 install --upgrade pynvim
sudo pip3 install --upgrade pynvim
sudo pip2 install --upgrade python-dateutil
sudo pip2 install --upgrade python-language-server
sudo pip3 install --upgrade python-language-server
sudo pip2 install --upgrade pytz
sudo pip2 install --upgrade requests_futures
sudo pip2 install --upgrade simplejson

# perl

sudo cpanm install Neovim::Ext

# ruby
sudo gem install neovim

# npm
yarn global add javascript-typescript-langserver
yarn global upgrade javascript-typescript-langserver
yarn global add neovim
yarn global upgrade neovim

# Minecraft.  PPA-based installer doesn't seem to work
sudo snap install mc-installer

# Install lightdm, as gdm3 has some issues with visual and other corruption on logout
echo "gdm3 shared/default-x-display-manager select lightdm" | sudo debconf-set-selections
echo "lightdm shared/default-x-display-manager select lightdm" | sudo debconf-set-selections
apt-get install lightdm

# Gnome settings
gsettings set org.gnome.Terminal.Legacy.Settings headerbar false

# Setup PIA
cd ~/Code
if [ ! -d "pia-openvpn" ]; then
  git clone https://github.com/erahhal/pia-openvpn.git
fi
cd pia-openvpn
git pull
./install.sh

# Setup synergy
cd ~/Code
if [ ! -d "synergy-core" ]; then
  git clone git@github.com:erahhal/synergy-core.git
fi
cd synergy-core
git checkout v1.8.8-ssl-patched
git pull
cd ext
mkdir -p gmock-1.6.0
cd gmock-1.6.0
unzip -o ../gmock-1.6.0.zip
cd ..
mkdir -p gtest-1.6.0
cd gtest-1.6.0
unzip -o ../gtest-1.6.0.zip
cd ../..
mkdir -p build
cd build
cmake ..
make
cd ..
sudo cp bin/syn* /usr/local/bin

# Setup mac os apfs fuse for mac disk support
cd ~/Code-vendor
if [ ! -d "apfs-fuse" ]; then
  git clone https://github.com/sgan81/apfs-fuse.git
fi
cd apfs-fuse
git pull
git submodule init
git submodule update
mkdir -p build
cd build
cmake ..
make
sudo cp apfs-* /usr/local/bin

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

if [ "$(readlink ~/.config/kitty)" != "$DIR/kitty" ]; then
  mv ~/.config/kitty ~/.config/kitty.orig
  ln -s $DIR/kitty ~/.config/kitty
fi

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
sudo ln -sf $DIR/android/70-oneplus3.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo service udev restart
sudo adb kill-server
