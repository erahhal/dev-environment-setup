#!/bin/bash
                               
DIR="$( cd "$( dirname "$0" )" && pwd )"

#-------------------------------------------------------------
# Mac
#-------------------------------------------------------------

# Install homebrew
if hash brew 2>/dev/null; then
  echo "Homebrew already installed"
else 
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi
brew tap caskroom/cask
brew update
brew install brew-cask
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
