#!/bin/bash

echo \
'digraph {
    rankdir = "LR"

    node
        [ shape = "rectangle" ]
        [ margin = "0.1" ]
        [ width = "0" ]
        [ height = "0" ]
'

top='completed-reads'

cd "$top"

for x in $( find -mindepth 1 -maxdepth 1 | sort )
do
    x="${x#./}"

    echo \
    "    \"${top}\" -> \"${x}\""

    cd "$x"

    for y in $( find -mindepth 1 -maxdepth 1 | sort )
    do
        y="${y#./}"

        echo \
        "        \"${x}\" -> \"${y}\""

        cd "$y"

        for z in $( find -mindepth 1 -maxdepth 1 | sort )
        do
            z="${z#./}"

            z="${z%.txt}"

            echo \
            "            \"${y}\" -> \"${z}\""
        done

        cd \
        ..
    done

    cd \
    ..
done

echo \
'}'
