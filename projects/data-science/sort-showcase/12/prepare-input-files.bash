#!/bin/bash

number_of_files=4
number_of_data_per_file=25000

# It could be also "for file_name in input{1..4}.txt", but then we would lose that nice explicit easy-to-change specification of number of files in a variable with a meaningful name (we couldn't use a variable, because brace expansion doesn't see variable values, because it's done before parameter expansion).
for (( file_number = 1 ; file_number <= number_of_files ; ++file_number ))
do
    file_name="input${file_number}.txt"

    seq "$number_of_data_per_file" |
        gawk '
            BEGIN {
                # The data look not random when "srand()" is put inside "{}". Why?
                srand()
                min_element = 1
                max_element = 1000
                min_list_length = 1
                max_list_length = 10
                min_datum_separator_length = 1
                max_datum_separator_length = 2
            }
            {
                list_length = int( ( max_list_length - min_list_length + 1 ) * rand() ) + min_list_length
                list = int( list_length * rand() )
                for ( element_number = 2 ; element_number <= list_length ; ++element_number ) {
                    element = int( ( max_element - min_element + 1 ) * rand() ) + min_element
                    list = list " " element
                }
                datum_separator_length = int( ( max_datum_separator_length - min_datum_separator_length + 1 ) * rand() ) + min_datum_separator_length
                datum_separator = ""
                for( k = 1 ; k <= datum_separator_length ; ++k ) {
                    datum_separator = datum_separator "\x00"
                }
                printf( list datum_separator )
            }
        ' \
        > "$file_name"

    sed -i'.bak' 's/\x00$//' "$file_name"
done
