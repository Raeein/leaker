#!/usr/bin/env bash

Help()
{
   echo "Compile and run Valgrind on school server(kinda). Run this container from the root of your C project."
   echo
   echo "Syntax:"
   echo "docker run -v $(pwd):/root/build --rm --name leaker raeein/leaker:test main_path"
   echo
   echo "arguments:"
   echo "main_path     Relative path from root of the project to the C file that has the main function"
   echo
}

while getopts ":h" option; do
   case $option in
      h)
         Help
         exit;;
   esac
done


EXEC="leaky"

if [ $# -le 1 ]
  then
    echo "Supply the correct number of argument. Run with -h for more infomation."
    echo "$0 /path/to/main.c [args]"
    exit 1
fi

while getopts "v:" opt; do
    case $opt in
        v) multi+=("$OPTARG");;
        #...
    esac
done
shift $((OPTIND -1))

command -v valgrind >/dev/null 2>&1 || { echo >&2 "Valgrind is not installed.  Aborting."; exit 1; }

echo "Path to main: $1"
echo "Compiling the binary..."

gcc -Wall -std=c99 -ggdb3 -o $EXEC $1
COMPILED=$?

if [ $COMPILED -ne 0 ]; then
    echo "Failed to compile. $COMPILED"
fi

echo 
echo "Running valgrind..."
valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all $EXEC

rm $EXEC