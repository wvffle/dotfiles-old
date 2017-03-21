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

create_link init.vim
replace ~\/ $HOME/ init.vim
