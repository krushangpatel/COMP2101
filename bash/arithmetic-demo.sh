#!/bin/bash
#
# this script demonstrates doing arithmetic

# Improve this script by asking the user to supply the two numbers
# Improve this script by demonstrating using subtraction and multiplication
# Improve this script by demonstrating the modulus operation
#   - the output should look something like:
#   - first divided by second gives X with a remainder of Y
# Improve this script by calculating and displaying the first number raised to the power of the second number

#firstnum=5
#secondnum=2
read -p "Give me 1st number::" firstnum
read -p "Give me 2nd number::" secondnum
#===============================================
sum=$((firstnum + secondnum))
subtraction=$((firstnum - secondnum))
dividend=$((firstnum / secondnum))
multiplication=$((firstnum * secondnum))
fpdividend=$(awk "BEGIN{printf \"%.2f\", $firstnum/$secondnum}")
power=$((firstnum ** secondnum))
reminder=$((firstnum % secondnum))

cat <<EOF
$firstnum reminder $secondnum is :: $reminder
$firstnum plus $secondnum is:: $sum
$firstnum subtraction $secondnum is:: $subtraction
$firstnum multiplication $secondnum is:: $multiplication
$firstnum power $secondnum is:: $power
$firstnum divided by $secondnum is:: $dividend
$firstnum reminder $secondnum is :: $reminder
  - More precisely, it is:: $fpdividend

EOF
