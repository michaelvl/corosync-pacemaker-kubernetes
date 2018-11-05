#! /bin/sh

set -e

COROSYNC_CONF=/dev/stdout
#COROSYNC_CONF=/etc/corosync/corosync.conf
COROSYNC_AUTHKEY=/etc/corosync/authkey


RING0_ADDRS="192.168.122.240 192.168.122.241"
COROSYNC_BINDNETADDR="192.168.122.0"

cat << EOF > $COROSYNC_CONF
totem {
  version: 2
  cluster_name: testcluster
  transport: udpu
EOF
if [ -n "${COROSYNC_AUTHKEY+set}" ]; then
    echo "  secauth: on" >> $COROSYNC_CONF
else
    echo "  secauth: off" >> $COROSYNC_CONF
fi
cat << EOF >> $COROSYNC_CONF
  interface {
    ringnumber: 0
    bindnetaddr: $COROSYNC_BINDNETADDR
    broadcast: yes
    mcastport: 5405
  }
}

quorum {
  provider: corosync_votequorum
  two_node: 1
}

nodelist {
EOF

for h in $RING0_ADDRS; do
cat << EOF >> $COROSYNC_CONF
  node {
    ring0_addr: $h
  }
EOF
done

cat << EOF >> $COROSYNC_CONF
}

logging {
  to_logfile: yes
  logfile: /var/log/corosync/corosync.log
  to_syslog: yes
  timestamp: on
}
EOF
