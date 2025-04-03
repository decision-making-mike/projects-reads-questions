#!/bin/bash

data_file_path="$1"

plot_file_path="$2"

if [[ -z "$data_file_path" ]] || [[ -z "$plot_file_path" ]] || [[ "${plot_file_path: -3}" != 'png' ]]
then
    >&2 \
        echo "Error"

    exit 1
fi

read -d '' title << EOM
Hours, at which there were more than 4 cars waiting\\\n\
for the green light at a made-up crossing in a made-up week.\\\n\
Outliers are determined using z-scores,\\\n\
separetely for every day of the week.
EOM

gnuplot \
    -p \
    -e "
        set title \"${title}\";

        set xlabel \"Day of the week\";

        set ylabel \"Hour\";

        set key outside;

        set xrange [0.7 : 7.3];

        set yrange [-1 : 24];

        set xtics ('Mon' 1, 'Tue' 2, 'Wed' 3, 'Thu' 4, 'Fri' 5, 'Sat' 6, 'Sun' 7);

        set ytics ($(
            for (( k = 0 ; k < 24 ; ++ k ))
            do
                echo -n "'${k}:00' $k"

                if [[ "$k" -lt 23 ]]
                then echo -n ','
                fi
            done
        ));

        set grid;

        set terminal png font \"Mono, 10\";

        set output '${plot_file_path}';

        plot \
            \"<( grep '0$' $data_file_path )\" \
            using 1:2 \
            title 'Non-outliers' \
            pt 4, \
                \"<( grep '1$' $data_file_path )\" \
                using 1:2 \
                title 'Outliers' \
                pt 3;
    "
