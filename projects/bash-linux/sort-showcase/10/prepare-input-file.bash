#!/bin/bash

number_of_files=4
number_of_data_per_file=25000
for (( file_number = 1 ; file_number <= number_of_files ; ++file_number ))
do
    file_name="input${file_number}.txt"
    seq "$number_of_data_per_file" |
        shuf |
            gawk \
            '
                {
                    number_of_separators = int( 2 * rand() + 1 )
                    separators=""
                    for( k = 1 ; k <= number_of_separators ; ++k ) separators = separators"\x0"
                    printf( $0 separators )
                }
            ' \
            > "$file_name"
    sed -i'.bak' 's/\x0$//' "$file_name"
done
