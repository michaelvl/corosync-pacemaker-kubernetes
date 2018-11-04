## Proof-of-concept for running Corosync and Pacemaker within a container.

The current hard-coded configuration assumes two hosts with IP addresses
192.168.122.240 and 192.168.122.241.

```
$ sudo make cluster-status

docker exec coropace crm_mon -1
Stack: corosync
Current DC: 192-168-122-241 (version 1.1.18-2b07d5c5a9) - partition with quorum
Last updated: Sun Nov  4 12:58:38 2018
Last change: Sun Nov  4 12:57:47 2018 by hacluster via crmd on 192-168-122-241

2 nodes configured
0 resources configured

Online: [ 192-168-122-240 192-168-122-241 ]

No active resources
```
