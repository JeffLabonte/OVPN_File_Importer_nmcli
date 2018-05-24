#!/bin/bash

cd ovpn_tcp/
for f in *.ovpn; do
	sudo nmcli connection import type openvpn file $f
done
