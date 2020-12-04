#!/bin/sh

# START IPSEC
ipsec start

# RUN SSH SERVER
/usr/sbin/sshd -D
