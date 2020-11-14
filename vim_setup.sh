#!/bin/bash

#copy vimrc file
cp vimrc ~/.vimrc

if [ ! -d ~/.vim/pack/vendor/start ]; then
    mkdir -p ~/.vim/pack/vendor/start
fi

cd ~/.vim/pack/vendor/start


# clone plugins - todo make it automatic
git clone --depth 1 https://github.com/majutsushi/tagbar         ./tagbar
git clone --depth 1 https://github.com/vim-airline/vim-airline   ./vim-airline
git clone --depth 1 https://github.com/Valloric/YouCompleteMe    ./YouCompleteMe
git clone --depth 1 https://github.com/justinmk/vim-syntax-extra ./vim-syntax-extra
git clone --depth 1 https://github.com/junegunn/fzf.vim          ./fzf
git clone --depth 1 https://github.com/mileszs/ack.vim           ./ack
git clone --depth 1 https://github.com/rhysd/vim-clang-format    ./vim-clang-format
git clone --depth 1 https://github.com/tpope/vim-endwise.git     ./vim-endwise
git clone --depth 1 https://github.com/preservim/nerdtree.git    ./nerdtree
git clone --depth 1 https://github.com/airblade/vim-gitgutter    ./vim-gitgutter

cd ./YouCompleteMe
git submodule update --init --recursive

sudo apt install -y cmake 
sudo apt install -y python3-dev 
python3 install.py --clangd-completer

sudo apt install -y clang-format 
sudo apt install -y ctags 
sudo apt install -y ack 
sudo apt install -y tmux 

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
