#!/bin/bash

import_ovpn(){
     cd ovpn_tcp/
     for f in *.ovpn; do
	sudo nmcli connection import type openvpn file $f
     done
}

set_credential_openvpn(){
    local user
    local password
    for f in $(nmcli -f NAME connection show | grep nordvpn.com.tcp)
    do
	    echo $f
            $sudo nmcli connection modify $f +vpn.data username=user +vpn.secrets password=password
    done
}

while getopts ":u:p:" opt; do
  case $opt in
    u) au=$OPTARG   ;;
    p) ap=$OPTARG   ;;
    \?)       echo "Invalid option: -$OPTARG\n Please use parameter -h for help" >&2
    exit 1 ;;

  esac
done



if [ -z $au ]
then
  echo "-u [username] is required"
  exit 1
fi

if [ -z $ap ]
then
  echo "-p [password] is required"
  exit 1
fi

set_credential_openvpn $au $ap
