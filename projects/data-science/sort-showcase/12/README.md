# Sort showcase task, version 11

## Overview

Sort data.

## Details

### Input

1. The data are in the files `input<number>.txt`, where `<number>` ranges from 1 (included) to 4 (included).
2. Each datum but the last is followed by a string of null characters. The string is of unknown length, and the length can be different for every datum.

### Output

1. The result should be in the file `output.txt`.
2. Each datum should be treated as a list of integers. The length of a list is unknown, but always at least 1. Each two consecutive elements in the list are separated with a space. The first element in the list should be interpreted as the index of the element according to which the data should be sorted. The indexes are counted from 0, and the first element ranges from 0 (included) to the number of elements minus 1 (included).
3. The data should be sorted from the largest to the smallest.
4. The result should not contain duplicates.
