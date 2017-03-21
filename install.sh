#!/bin/bash

for module in *
do
  if [ -f $module/install.sh ]
  then

    echo "installing module $module..."
    module=$module $module/install.sh

  else

    if [ -d $file ]
    then

      echo "installing module $module..."
      dir=~/.$module
      mkdir -p $dir

      for f in $module/*
      do
        ln -s $PWD/$f $dir/${f##*/}
      done
    fi

  fi
done

echo "done"
