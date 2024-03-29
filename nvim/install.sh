#!/bin/bash

dir=~/.config/$module
mkdir -p $dir

function create_link {
  dest=$2

  if [ -z "$dest" ]
  then
    dest=$1
  fi

  ln -s $PWD/$module/$1 $dir/$dest
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
create_link tern-project.json .tern-project
replace ~\/ $HOME/ init.vim

if [[ ! -d $dir/dein ]]
then
  clone Shougo/dein.vim dein/repos/github.com/Shougo/dein.vim
fi

if [[ ! -x $(which npm) ]]
then
  sudo pacman -S nodejs
fi

if [[ ! -x $(which eslint) ]]
then
  npm install -g eslint
fi

if [[ ! -x $(which jscs) ]]
then
  npm install -g jscs
fi

if [[ ! -x $(which tern) ]]
then
  npm install -g tern
fi
