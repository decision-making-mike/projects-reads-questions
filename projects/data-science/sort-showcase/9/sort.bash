#!/bin/bash

sort -u -r -z -n input.txt | sed 's/\x00$//' > output.txt
