#!/bin/bash

sort -u -r -z -n -t ' ' -k 2,2 input[1-4].txt |
    sed 's/\x00$//' > output.txt
