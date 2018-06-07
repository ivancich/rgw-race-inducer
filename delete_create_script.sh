#!/bin/sh

finish() {
    trap '' SIGINT SIGTERM
    kill -TERM $(jobs -p)
    wait
    echo "$0: exited early"
    exit 1
}
trap finish SIGINT SIGTERM

swift -A http://localhost:8000/auth -U test:tester -K testing post test

dir=$(dirname $0)

${dir}/delete_create_object.sh one &
${dir}/delete_create_object.sh two &
${dir}/delete_create_object.sh three &
${dir}/delete_create_object.sh four &
${dir}/delete_create_object.sh five &
${dir}/delete_create_object.sh six &
${dir}/delete_create_object.sh seven &
${dir}/delete_create_object.sh eight &
${dir}/delete_create_object.sh nine &
${dir}/delete_create_object.sh ten &

wait

echo Done all
