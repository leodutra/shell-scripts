#!/bin/sh
mv /etc/resolv.conf /etc/resolv.conf.save
cat <<EOT >> /etc/resolv.conf
domain localdomain
nameserver 189.38.95.95
nameserver 8.8.8.8
nameserver 2804:10:10::10
EOT
