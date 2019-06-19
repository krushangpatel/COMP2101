#!/bin/bash
################
# Data Gathering
################
# grep is used to filter ip command output so we don't have extra junk in our output
# stream editing with sed and awk are used to extract only the data we want displayed
# we use the hostname command to get our system name
myhostname=$(hostname)
# the default route can be found in the route table normally
# the router name is obtained with getent
defaultrouteraddress=$(ip r s default| cut -d ' ' -f 3)
defaultroutername=$(getent hosts $defaultrouteraddress|awk '{print $2}')
# finding external information relies on curl being installed and relies on live internet connection
externaladdress=$(curl -s icanhazip.com)
externalname=$(getent hosts $externaladdress | awk '{print $2}')
cat <<EOF
System Identification Summary
=============================
Hostname      : $myhostname
Default Router: $defaultrouteraddress
Router Name   : $defaultroutername
External IP   : $externaladdress
External Name : $externalname
EOF
# Define the interface being summarized
# interface=$( ls -l /sys/class/net/ | awk '{print $9}')
# loopback: sudo ifconfig lo:10 127.0.0.2 netmask 255.0.0.0 up
# Find an address and hostname for the interface being summarized
# we are assuming there is only one IPV4 address assigned to this interface
# Identify the network number for this interface and its name if it has one
count=$(lshw -class network | awk '/logical name:/{print $3}' | wc -l)
for((w=1;w<=$count;w+=1));
do
  interface=$(lshw -class network |
    awk '/logical name:/{print $3}' |
      awk -v z=$w 'NR==z{print $1; exit}')
  if [[ $interface = lo* ]] ; then continue ; fi
  ipv4ipaddress=$(ip a s $interface | awk -F '[/ ]+' '/inet /{print $3}')
  ipv4hostname=$(getent hosts $ipv4ipaddress | awk '{print $2}')
  networkipaddress=$(ip route list dev $interface scope link|cut -d ' ' -f 1)
  networknumber=$(cut -d / -f 1 <<<"$networkipaddress")
  networkname=$(getent networks $networknumber|awk '{print $1}')
  echo Interface $interface:
  echo ===============
  echo Address         : $ipv4ipaddress
  echo Name            : $ipv4hostname
  echo Network Address : $networkipaddress
  echo Network Name    : $networkname
done
