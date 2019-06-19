#!/bin/bash
titles=("one" "two" "three")
number=$(( ${#titles[@]}))
random=$(( RANDOM % number))
time=$(date +'%A, %I:%M %p')
hostname=$(hostname)
weekday=$(date +%u)
variable=$(cat <<EOF
Welcome to planet $hostname, ${titles[$random]} $USER!

$(if [ "$weekday" = "6" ] || [ "$weekday" = "7" ]
then
   echo "It is $time on Weekend."
else
   echo "It is $time on Weekday."
fi
)
EOF
)
cat <<EOF
$(cowsay$variable)
EOF
