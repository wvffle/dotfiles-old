#!/bin/bash

dir=~/.config/$module
mkdir -p $dir

function create_link {
  ln -s $PWD/$module/$1 $dir/$1
}

function escape {
  echo "$1" | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g'
}

function replace {
  sed -i "s/$(escape $1)/$(escape $2)/g" $dir/$3
}

function clone {
  git clone https://github.com/$1 $dir/$2
}

create_link init.vim
replace ~\/ $HOME/ init.vim
clone Shougo/dein.vim dein/repos/github.com/Shougo/dein.vim

if which programname > /dev/null
then
  sudo pacman -S nodejs
fi
npm install -g tern
