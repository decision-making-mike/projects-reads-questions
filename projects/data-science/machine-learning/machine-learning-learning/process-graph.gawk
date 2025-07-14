#!/bin/gawk

function get_color( first_category , second_category ){
    if( second_category == "" ) category = first_category
    else category = second_category

    if( category == "Study\\l" ) return "lightgoldenrod"
}

BEGIN{
    getline
    printf( \
        "graph {\n\tlabel = \"%s\"\n\trankdir = \"LR\"\n\tnode\n\t\t[ shape = \"record\" ]\n" ,
        $0 "\nDiagram generated on " strftime( "%b %d, %Y" ) "." \
    )
    getline
}

{
    if( $0 !~ "->" ){
        name = $1
        label_name = $2
        first_category = $3
        second_category = $4

        printf( \
            "\t%s\n\t\t[ label = \"%s%s%s\" ]\n\t\t[ style = \"filled\" ]\n\t\t[ fillcolor = \"%s\" ]\n" ,
            name ,
            label_name ,
            "|" first_category ,
            second_category == "" ? "" : "|" second_category ,
            get_color( first_category, second_category ) \
        )
    } else print
}

END{
    print "}"
}
