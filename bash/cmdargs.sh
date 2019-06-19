#!/bin/bash
# loop through the cmd line arg
while [ $# -gt 0 ]; do
  # tell the user how many things are left on the command line
  echo "There are $# things left to process on the command line."
  # display whatever is in $1
  echo '$1 has '"''$1' in it."
  case $1 in
    -h )
    echo 'You added "-h" for help. '
    ;;
    -v )
    echo 'You added "-v" for varbose. '
    ;;
    -d )
      case "$2" in
        [1-5] )
        echo "You added -d for debug level $2"
        shift
        ;;
        *)
        echo "The -d option must be followed with a number [1-5]. "
        shift
      esac
    ;;
    *)
    err0rs=$1
    echo "Error: unkown value $err0rs"
    ;;
    esac
# everytime through the loop, shift the arguments left
  # this decrements the argument count for us
  shift
  # telling the user we shifted things
  echo "Shifted command line, leaving $# things left to process."
  echo "--------------------------"
  # check in the loop is anything is remaining?
done
echo "Done"
