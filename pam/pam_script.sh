#!/bin/bash

if [ $PAM_USER = "vagrant" ]; then
  exit 0
fi

if id -nG "$PAM_USER" | grep -qw "admin"; then
    exit 0;
fi

if [[ `date +%u` > 5 ]]
then
    exit 1
else
    exit 0
fi
