#!/bin/bash

gawk '
    BEGIN {
        RS = "\x00"
    }
    {
        # We need to add 1 because the input specification says that indexes start from 0.
        sort_key_index = $1 + 1
        
        # Swap.
        temporary = $sort_key_index
        $sort_key_index = $1
        $1 = temporary

        # Handle the fact that multiple consecutive null characters create empty records.
        if( $0 != "" ) {
            printf( sort_key_index " " $0 "\x00" )
        }
    }
' input[1-4].txt |
    sort -u -r -z -n -t ' ' -k 2 |
    gawk '
        BEGIN {
            RS = "\x00"
        }
        {
            # We need to add 1 because we have increased the length of the record, having added the first field.
            swap_index = $1 + 1
            
            # Swap.
            temporary = $swap_index
            $swap_index = $2
            $2 = temporary

            $1 = ""
            # We use substr() to omit one character, i.e. a space, the default output field separator.
            print substr( $0 , 2 )
        }
    ' |
    sed 's/\x00$//' > output.txt
