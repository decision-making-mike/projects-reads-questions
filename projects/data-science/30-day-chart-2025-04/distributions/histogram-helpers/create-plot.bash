#!/bin/bash

data_file_path="$1"

plot_file_path="$2"

if [[ -z "$data_file_path" ]] || [[ -z "$plot_file_path" ]] || [[ "${plot_file_path: -3}" != 'png' ]]
then
    >&2 echo "Error"

    exit 1
fi

read -d '' title << EOM
Percentage of empty space\\\n\
in trucks of a made-up company\\\n\
at 12:00 PM on Jan 1, 2024
EOM

gnuplot \
    -p \
    -e "
        set \
        style \
        histogram \
        clustered;

        set \
        yrange \
        [0 : $(
            x="$(
                cut \
                -d' ' \
                -f2 \
                "$data_file_path" \
                    | sort \
                    -rn \
                        | head \
                        -n1
            )"
            echo "$(
                bc <<< "$x + 10 - $x % 10"
            )"
        )];
        
        set \
        style \
        data \
        histogram;

        set \
        style \
        fill \
        solid \
        border;

        set \
        xlabel \
        \"Buckets\";

        set \
        ylabel \
        \"Empty space percentage\";

        set \
        title \
        \"${title}\";

        set \
        key \
        off;

        set \
        output \
        '${plot_file_path}';

        set \
        terminal \
        png \
        font \"Mono, 10\";

        set \
        grid;

        plot \
        \"${data_file_path}\" \
        using 2:xticlabels(1);
    "
