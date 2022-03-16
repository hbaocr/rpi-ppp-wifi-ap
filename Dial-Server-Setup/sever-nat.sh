#!/bin/bash

ethernet_src_iface=enp0s3
ethernet_share_iface=ppp0
sudo iptables --flush
sudo iptables --table nat --flush
sudo iptables --delete-chain
sudo iptables --table nat --delete-chain


sudo iptables -t nat -A POSTROUTING -o $ethernet_src_iface -j MASQUERADE

sudo iptables -A FORWARD -i $ethernet_share_iface -o $ethernet_src_iface -m state --state RELATED,ESTABLISHED -j>
sudo iptables -A FORWARD -i $ethernet_src_iface -o $ethernet_share_iface -j ACCEPT

#view
sudo iptables -L -n -v
sudo iptables -t nat -L -n -v