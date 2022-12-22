#!/usr/bin/env bash

Help()
{
   echo "Compile and run Valgrind on school server (kinda). Run this container from the root of your C project."
   echo
   echo "Syntax:"
   echo "docker run -v \$(pwd):/root/build --rm --name leaker raeein/leaker:latest -m main_path -v \"args\""
   echo
   echo "arguments:"
   echo "-m     Relative path from root of the project to the C file that has the main function."
   echo "-v     Arguments required to run the executable. Put all the args in a \" \" or "
   echo "       add them with -v flags. ex: -v arg1 -v arg2."
   echo "-h     Help Menu."
   echo
}


while getopts "m:v:h" opt; do
   case $opt in
      m) MAIN="$OPTARG";;
      v) ARGS+="$OPTARG ";;
      h) Help; exit;;
      *) echo "Unknown";;
   esac
done
shift $((OPTIND -1))

if [ -z "$MAIN" ]
  then
    echo 
    echo "No main file was give. Run with -h for more infomation"
    exit 1
fi


echo "Main: $MAIN"
echo "Args: $ARGS"


EXEC="leaky"

command -v valgrind >/dev/null 2>&1 || { echo >&2 "Valgrind is not installed.  Aborting."; exit 1; }

echo "Compiling the binary..."

gcc -Wall -std=c99 -ggdb3 -o "$EXEC" "$MAIN"
COMPILED=$?

if [ $COMPILED -ne 0 ]; then
    echo "Failed to compile."
    exit 1
fi

echo "Running valgrind..."
valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all ./"$EXEC" "$ARGS"

echo "Cleaning up..."
rm $EXEC