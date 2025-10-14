#!/bin/bash

# This is an improved version of solution 12. It revealed to me when I was reading the GNU sort's manual (https://www.gnu.org/software/coreutils/manual/html_node/sort-invocation.html). I discovered I used the decorate-sort-undecorate idiom which the manual mentions (see https://en.wikipedia.org/wiki/Schwartzian_transform), but with an additional, bug-prone swapping (of which an additional hindrance, beside being bug-prone, might be the time cost, but I'm not sure, as on my machine it runs quite fast for 100k data). So, compared to the not improved version, this one avoids the swapping, and additionally replaces the second longer GAWK script with shorter cut invokation.

gawk '
    BEGIN {
        RS = "\x00"
    }
    {
        # We need to add 1 because the input specification says that indexes start from 0.
        sort_key_index = $1 + 1

        # Handle the fact that multiple consecutive null characters create empty records.
        if( $0 != "" ) {
            printf( $sort_key_index " " $0 "\x00" )
        }
    }
' input[1-4].txt |
    sort -u -r -z -n -t ' ' -k 1,1 |
    cut -d ' ' -f 2- -z |
    sed 's/\x00$//' > output.txt
