#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

#-------------------------------------------------------------
# Mac
#-------------------------------------------------------------

if [ ! -e "/Applications/Xcode.app" ]; then
  echo "Please go to the app store and install XCode first before running this script."
  exit 1
fi
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# Disable two-finger swipe navigation in browsers
defaults write "Apple Global Domain" AppleEnableSwipeNavigateWithScrolls -int 0

# ZSH setup
# Based on: https://gist.github.com/kevin-smets/8568070
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
chmod -R 755 /usr/local/share/zsh

# Install homebrew
if hash brew 2>/dev/null; then
  echo "Homebrew already installed"
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
brew tap homebrew/cask-cask
brew update
brew install ack
brew install aspell
brew install bash-completion
brew install cmake
brew install coreutils
brew install ctags-exuberant
brew install exa
brew uninstall ffmpeg --force
brew install ffmpeg --with-libvorbis --with-libass --with-freetype --with-openssl --with-libvpx --with-fdk-aac --with-sdl2 --with-frei0r --with-opencore-amr --with-openjpeg --with-opus --with-rtmpdump --with-schroedinger --with-speex --with-theora --with-tools
brew install git
brew install gnu-sed
brew install go
brew install llvm
brew install lsd
brew install mosh
brew install neovim/neovim/neovim
brew install nodejs
brew install pyenv
brew install python
# Needed for tmux copy and paste
brew install reattach-to-user-namespace
brew install ripgrep
brew install the_silver_searcher
brew install tidy-html5
brew install tmux
brew install vim --with-python --override-system-vim
brew install wget
brew install yarn
brew install zsh-syntax-highlighting

sudo ln -s /usr/local/bin/nvim /usr/local/bin/vi

brew cask install anki
brew cask install diffmerge
brew cask install docker
brew cask install electrum
brew cask install etcher
brew cask install evernote
brew cask install firefox
brew cask install google-chrome
brew cask install google-cloud-sdk
brew cask install gimp
brew cask install spotify
brew cask install steam
brew cask install unetbootin
brew cask install virtualbox
brew cask install vlc
brew cask install xquartz

# Yarn setup
yarn global add neovim

# Iterm2 setup
brew cask install iterm2
cd ~/Downloads
wget "https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Solarized%20Dark%20-%20Patched.itermcolors"

echo "Please install the \"Solarized Dark - Patched.itermcolors\" file in ~/Downloads"
echo "iTerm → preferences → profiles → colors → load presets."
echo ""
read -p "Press enter after installed."

# FAC (Git Fix All Conflicts)

brew tap mkchoi212/fac https://github.com/mkchoi212/fac.git
brew install fac

# Python setup
pyenv install 2.7.16
pyenv global 2.7.16
PIP2=$(pyenv root)/versions/2.7.16/bin/pip

$PIP2 install --upgrade neovim
pip3 install --upgrade neovim
pip3 install --upgrade PIL
pip3 install --upgrade Pillow
pip3 install --upgrade neovim
# for FormatJSON command in VIM
pip3 install --upgrade simplejson
pip3 install --upgrade pep8
pip3 install --upgrade pylint

# for python libs that need freetype headers
ln -s /usr/local/include/freetype2 /usr/local/include/freetype

# Ruby dependencies
sudo gem install neovim

# Add emacs daemon as service
launchctl load -w ${DIR}/emacs/gnu.emacs.daemon.plist

# Arduino 1.16.13, which is latest version supported by teensy
brew cask install https://raw.githubusercontent.com/caskroom/homebrew-cask/5ed77c9d0e487f2a2925c2b8c68b846fbd382109/Casks/arduino.rb

# Google Cloud sdk
gcloud init
gcloud components install kubectl container-builder-local docker-credential-gcr

