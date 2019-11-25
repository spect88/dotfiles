#!/bin/bash

link_file () {
  src=$1
  dst=$2
  dir=$(dirname "$dst")
  if [[ ! -d "$dir" ]] ; then
    echo "$dir does not exist, skipping..." 1>&2
    return
  fi

  if [[ -e "$dst" ]] ; then
    if [[ -L "$dst" ]] ; then
      echo "$dst is already a symlink, skipping..." 1>&2
      return
    fi

    echo "$dst already exists, saving a backup: $src.local" 1>&2
    mv $dst "$src.local"
  fi

  echo "Linking: $dst"
  ln -s $src $dst
}

link_file ~/git/dotfiles/karabiner-elements.json ~/.config/karabiner/assets/complex_modifications/karabiner-elements.json
link_file ~/git/dotfiles/.bashrc ~/.bashrc
link_file ~/git/dotfiles/.bash_profile ~/.bash_profile
link_file ~/git/dotfiles/.tmux.conf ~/.tmux.conf
link_file ~/git/dotfiles/.gitconfig ~/.gitconfig
link_file ~/git/dotfiles/.gitignore_global ~/.gitignore_global
link_file ~/git/dotfiles/init.vim ~/.config/nvim/init.vim
