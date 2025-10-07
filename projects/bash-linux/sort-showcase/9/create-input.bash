#!/bin/bash

number_of_data=100000
seq 1 "$number_of_data" |
    gawk \
    '
        {
            print
            print
        }
    ' |
        shuf |
            gawk \
            -v number_of_data="$number_of_data" \
            '
                {
                    number_of_separators = int( 2 * rand() + 1 )
                    separators=""
                    for( k = 1 ; k <= number_of_separators ; ++k ) separators = separators"\x0"
                    printf( $0 separators )
                }
            ' \
            > input.txt
sed -i'.bak' 's/\x0$//' input.txt
