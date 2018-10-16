#!/bin/bash


message="$1"

[ -z "$message" ] && message="update"

git add . 

echo "list all added files ?(y/n) "
read ans

if [ "$ans" ==  "y" -o "$ans" == "Y" -o "$ans" == "yes" ]
then
    git status

elif [ "$ans" == "n" -o "$ans" == "N"  -o "$ans" == "no" ]
then
    echo "added ..."
else
    echo "wrong args"
fi

git commit -m "$message"

git push origin master


