#!/bin/sh

port_lo=8000
port_hi=8002

finish() {
    trap '' SIGINT SIGTERM
    kill -TERM $(jobs -p)
    wait
    echo "$0: exited early"
    exit 1
}
trap finish SIGINT SIGTERM

i=1
objects=100
prefix=$1

list_out=$1.list
echo $(date) > $list_out

while [ $i -lt $objects ]
do
    object=$prefix.`date +%Y-%m-%d:%H:%M:%S`.$i
    touch $object

    port1=$(( RANDOM % (port_hi - port_lo + 1 ) + port_lo ))
    port2=$(( RANDOM % (port_hi - port_lo + 1 ) + port_lo ))
    port3=$(( RANDOM % (port_hi - port_lo + 1 ) + port_lo ))

    swift -A http://localhost:${port1}/auth -U test:tester -K testing upload test $object >/dev/null
    swift -A http://localhost:${port2}/auth -U test:tester -K testing delete test $object >/dev/null &
    swift -A http://localhost:${port3}/auth -U test:tester -K testing list test >>$list_out

    i=`expr $i + 1`
    rm -f $object &
done

wait

echo Done $1
