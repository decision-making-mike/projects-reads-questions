#!/bin/bash

for (( k = 0 ; k < 5 ; ++ k ))
do
    echo \
    "$(
        if [[ "$k" -eq 0 ]]
        then echo 0
        else echo "$(( 20 * k + 1 ))"
        fi
    )–$(( 20 * ( k + 1 ) )) $(( RANDOM % 18 ))"
done
