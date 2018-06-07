#!/bin/sh

swift -A http://localhost:8000/auth -U test:tester -K testing list test
