#!/bin/bash

dir=~/.config/$module
mkdir -p $dir

for f in $module/*
do
  file=${f##*/}
  [[ $file =~ ^install.sh$ ]] && continue

  ln -s $PWD/$f $dir/$file
done
