#!/bin/bash

sort -u -r -z -n input[1-4].txt | sed 's/\x00$//' > output.txt
