#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No arguments supplied. Name of the role is required!"
    exit 1
else
echo "Creating dir strucrure for $1 role."
fi

# The $# variable will tell you the number of input arguments the script was passed.
# Or you can check if an argument is an empty string or not like:

if [ -z "$1" ]
  then
    echo "No arguments supplied. Name of the role is required!"
    exit 1
fi
# The -z switch will test if the expansion of "$1" is a null string or not. If it is a null string then the body is executed

if [ -d $1 ]
  then
    echo "Directory $1 exists."
    exit 1
else
    for dir in defaults files handlers meta tasks tests vars
    do
        mkdir -p $1/$dir
        touch $1/$dir/main.yml
        echo "---" > $1/$dir/main.yml
        echo "#$dir file for $1" >> $1/$dir/main.yml
    done
    touch $1/README.md
fi



