#!/bin/gawk

BEGIN {
    word_character_regex = "[a-zA-Zäöüß'-]"
    before_word = "<span class=\"word\">"
    after_word = "</span>"
    print "<style>"
    print "\t.word {"
    print "\t\tborder: 2px solid grey;"
    print "\t\tpadding: 2px;"
    print "\t\tline-height: 2rem;"
    print "\t}"
    print "</style>"
}
{
    split( $0 , a , "" )
    line = ""
    if( $0 != "" ){
        line = before_word
    }
    line = line a[ 1 ]
    for( k=2 ; k <= length( a ) ; ++k ){
        if( match( a[ k ] , word_character_regex )==0 ){
            if( match( a[ k-1 ] , word_character_regex )!=0 ){
                line = line after_word a[ k ]
            }else{
                line = line a[ k ]
            }
        }else{
            if( match( a[ k-1 ] , word_character_regex )==0 ){
                line = line "\n" before_word a[ k ]
            }else if( k==length( a ) ){
                line = line a[ k ] after_word
            }else{
                line = line a[ k ]
            }
        }
    }
    if( $0 != "" ){
        printf( "%s\n<br>\n" , line )
    }else{
        printf( "%s<br>\n" , line )
    }
}
