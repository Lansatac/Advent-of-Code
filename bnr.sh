#!/bin/bash

if [[ -n "$1" ]]; then
	dmd $1.d -O -release -inline -of$1.exe && cat input/$1 | ./$1.exe
else
	echo "missing name!"
fi
