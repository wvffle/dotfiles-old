#!/bin/bash

function install {
  module=$1

  [[ -f $module/install.sh ]] && {
    echo "installing module $module..."
    module=$module bash $module/install.sh

    return
  }

  [[ -d $module ]] && {
    echo "installing module $module..."
    dir=~/.$module
    mkdir -p $dir

    for f in $module/*
    do
      ln -s $PWD/$f $dir/${f##*/}
    done
  }
}

[[ $# -gt 0 ]] && {

  for $module in $@
  do
    [[ -f $module ]] || {
      echo "module '$module' not found"
      exit 1
    }
  done

  for $module in $@
  do
    install $module
  done
  echo done

  exit 0
}

for module in *
do
  install $module
done
echo done
