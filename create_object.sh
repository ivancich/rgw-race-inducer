#!/bin/sh

echo "hello $(date)" > foobar

swift -A http://localhost:8000/auth -U test:tester -K testing upload test foobar

rm -f foobar
