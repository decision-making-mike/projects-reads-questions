#!/bin/bash

number_of_data=100000
seq 1 "$number_of_data" |
    shuf |
        gawk \
        -v number_of_data="$number_of_data" \
        '
            {
                if( NR == number_of_data ) printf( $0 )
                else print
            }
        ' |
            tr '\n' '\0'
