#!/bin/gawk

NR > 2 {
    day = $1
    hour = $2
    days[ ++ k ] = day
    hours[ k ] = hour
    sums[ day ] += hour
    ++ lengths[ day ]
}

END {
    for ( day in sums ) {
        if ( lengths[ day ] == 0 ) continue
        mean = sums[ day ] / lengths[ day ]
        for ( k in days ) {
            if ( days[ k ] == day ) {
                sum2 += ( hours[ k ] - mean ) ** 2
            }
        }
        variance = sum2 / lengths[ day ]
        standard_deviation = sqrt( variance )
        for ( k in days ) {
            if ( days[ k ] == day ) {
                if ( standard_deviation != 0 ) {
                    z_score = ( hours[ k ] - mean ) / standard_deviation
                    is_outlier = z_score > 1.5 || z_score < -1.5
                } else is_outlier = 0
                printf( "%d\t%d\t%d\n" , days[ k ] , hours[ k ] , is_outlier )
            }
        }
    }
}
