#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

#-------------------------------------------------------------
# Mac
#-------------------------------------------------------------

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
brew install aspell
brew install brew-cask
brew install nodejs
brew install llvm
brew install vim --with-python --override-system-vim
brew install macvim --with-python --override-system-vim
brew install cmake
brew install bash-completion
brew install tmux
brew install eslint
brew install tidy-html5
brew install go
brew install ctags-exuberant
brew install neovim/neovim/neovim
brew uninstall ffmpeg --force
brew install ffmpeg --with-libvorbis --with-libass --with-freetype --with-openssl --with-libvpx --with-fdk-aac --with-sdl2 --with-frei0r --with-opencore-amr --with-openjpeg --with-opus --with-rtmpdump --with-schroedinger --with-speex --with-theora --with-tools
# Needed for tmux copy and paste
brew install reattach-to-user-namespace
sudo ln -s /usr/local/bin/nvim /usr/local/bin/vi
brew cask install google-chrome
brew cask install thunderbird
brew cask install firefox
brew cask install electrum
brew cask install retinacapture
brew cask install gimp
brew cask install pencil
brew cask install xquartz
brew cask install inkscape
brew cask install omnigraffle
brew cask install sourcetree
brew cask install diffmerge
brew cask install versions
brew cask install freemind
brew cask install evernote
brew cask install spotify
brew cask install virtualbox
brew cask install vlc
brew cask install wechat
brew cask install skype
brew cask install adium
brew cask install steam
brew cask install adobe-reader
brew cask install mixxx
brew cask install intellij-idea-ce
brew cask install atom
brew cask install logitech-control-center
brew cask install twitterrific
brew cask install iterm2
brew cask install anki
brew cask install emacs

pip install PIL
pip install Pillow
pip install neovim
# for FormatJSON command in VIM
pip install simplejson
pip install pep8
pip install pylint

# for python libs that need freetype headers
ln -s /usr/local/include/freetype2 /usr/local/include/freetype

# Add emacs daemon as service
launchctl load -w ${DIR}/emacs/gnu.emacs.daemon.plist

# Arduino 1.16.13, which is latest version supported by teensy
brew cask install https://raw.githubusercontent.com/caskroom/homebrew-cask/5ed77c9d0e487f2a2925c2b8c68b846fbd382109/Casks/arduino.rb

