#!/bin/bash

top=completed-reads
result='digraph {'$'\n'
result+='    node'$'\n'
result+='        [ shape = "plaintext" ]'$'\n'
result+=$'\n'
result+='    1 [label=<
        <TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0" CELLPADDING="4">
            <TR>'$'\n'

cd "$top"
result+="                <TD ROWSPAN=\"$( find -mindepth 3 -maxdepth 3 | wc -l )\">${top}</TD>"$'\n'
for x in $( find -mindepth 1 -maxdepth 1 | sort ) ; do
    x="${x#./}"
    cd "$x"
    result+="                <TD ROWSPAN=\"$( find -mindepth 2 -maxdepth 2 | wc -l )\">${x}</TD>"$'\n'
    for y in $( find -mindepth 1 -maxdepth 1 | sort ) ; do
        y="${y#./}"
        cd "$y"
        result+="                <TD ROWSPAN=\"$( find -mindepth 1 -maxdepth 1 | wc -l )\">${y}</TD>"$'\n'
        for z in $( find -mindepth 1 -maxdepth 1 | sort ) ; do
            z="${z#./}"
            z="${z%.txt}"
            result+="                <TD>${z}</TD>
            </TR>
            <TR>"$'\n'
        done
        cd ..
    done
    cd ..
done

# Remove the last two lines, i.e. "<TR>" and the empty line resulting from using "<<<".
result="$( head -n -2 <<< "$result" )"
result+='
        </TABLE>
    >];
}'
echo "$result"
