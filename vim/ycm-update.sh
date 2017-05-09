#!/bin/bash

cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
if [ "$(uname)" == "Darwin" ]; then
  cd third_party/ycmd
  export PATH_TO_LLVM_ROOT=$(brew list llvm | sed -n 1p | sed 's/^\(.*\/llvm\/[^/]*\).*$/\1/')
  cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT="$PATH_TO_LLVM_ROOT" -DPYTHON_INCLUDE_DIR=/usr/local/Frameworks/Python.framework/Headers -DPYTHON_LIBRARY=/usr/local/Frameworks/Python.framework/Python . ./cpp
  /usr/local/bin/python ./build.py --clang-completer --gocode-completer
else
  ./install.py --clang-completer --gocode-completer
fi
