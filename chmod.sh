#!/bin/bash

for file in *
do
  if [ -f $file/install.sh ]
  then
    chmod +x $file/install.sh
  fi
done
