#!/bin/bash

if [[ -n "$1" ]]; then
	cat input/$1 | rdmd $1.d -of$1.exe
else
	echo "missing name!"
fi
