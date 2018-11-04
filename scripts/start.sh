#! /bin/sh

corosync
service pacemaker start

sleep 5
tail -f /var/log/pacemaker.log
