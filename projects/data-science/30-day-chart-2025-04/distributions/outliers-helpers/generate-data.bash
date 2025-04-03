#!/bin/bash

function f {
    hour="$1"

    echo \
    -e \
    "$(
        date \
        -d "$(
            date \
            -d "Monday + $k days"
        )" \
        '+%u'
    )\t${hour}"
}

echo \
-e \
"Day of the week\tHour"

for (( k = 1 ; k < 8 ; ++ k ))
do
    number_of_hours="$(( RANDOM % 23 + 2 ))"
    for (( m = 0 ; m < number_of_hours / 6 * 5 ; ++ m ))
    do f "$(( RANDOM % 13 ))"
    done
    for (( m = 0 ; m < number_of_hours / 6 ; ++ m ))
    do f "$(( RANDOM % 11 + 13 ))"
    done
done \
    | sort \
    --numeric-sort \
    --key=1,1 \
    --key=2,2 \
        | uniq
