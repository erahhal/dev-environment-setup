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

# Install homebrew
if hash brew 2>/dev/null; then
  echo "Homebrew already installed"
else
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi
brew tap caskroom/cask
brew update
brew install coreutils
brew install gnu-sed
brew install ack
brew install ripgrep
brew install the_silver_searcher
brew install git
brew install lsd
brew install aspell
brew install nodejs
brew install mosh
brew install llvm
brew install vim --with-python --override-system-vim
# brew install macvim --with-python --override-system-vim
brew install cmake
brew install bash-completion
brew install tmux
brew install tidy-html5
brew install go
brew install ctags-exuberant
brew install exa
brew install neovim/neovim/neovim
brew uninstall ffmpeg --force
brew install ffmpeg --with-libvorbis --with-libass --with-freetype --with-openssl --with-libvpx --with-fdk-aac --with-sdl2 --with-frei0r --with-opencore-amr --with-openjpeg --with-opus --with-rtmpdump --with-schroedinger --with-speex --with-theora --with-tools
# Needed for tmux copy and paste
brew install reattach-to-user-namespace
sudo ln -s /usr/local/bin/nvim /usr/local/bin/vi
brew cask install google-chrome
brew cask install firefox
brew cask install electrum
brew cask install gimp
brew cask install xquartz
brew cask install diffmerge
brew cask install evernote
brew cask install spotify
brew cask install virtualbox
brew cask install vlc
brew cask install skype
brew cask install steam
brew cask install anki
brew cask install google-cloud-sdk
brew cask install hipchat
brew cask install unetbootin
brew cask install etcher

# FAC (Git Fix All Conflicts)

brew tap mkchoi212/fac https://github.com/mkchoi212/fac.git
brew install fac

pip2 install --upgrade PIL
pip2 install --upgrade Pillow
pip2 install --upgrade neovim
# for FormatJSON command in VIM
pip2 install --upgrade simplejson
pip2 install --upgrade pep8
pip2 install --upgrade pylint

# for python libs that need freetype headers
ln -s /usr/local/include/freetype2 /usr/local/include/freetype

# Add emacs daemon as service
launchctl load -w ${DIR}/emacs/gnu.emacs.daemon.plist

# Arduino 1.16.13, which is latest version supported by teensy
brew cask install https://raw.githubusercontent.com/caskroom/homebrew-cask/5ed77c9d0e487f2a2925c2b8c68b846fbd382109/Casks/arduino.rb

# Google Cloud sdk
gcloud init
gcloud components install kubectl container-builder-local docker-credential-gcr

