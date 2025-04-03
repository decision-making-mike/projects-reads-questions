#!/bin/gawk

NR > 2 {
    first[ ++ k ] = $1
    second[ k ] = $2
    sum += data[ k ]
}

END {
    mean = sum / length( second )
    for ( m in second ) {
        sum2 += ( second[ m ] - mean ) ** 2
    }
    variance = sum2 / length( second )
    standard_deviation = sqrt( variance )
    for ( m in second ) {
        z_score = ( second[ m ] - mean ) / standard_deviation
        is_outlier = z_score > 2 || z_score < -2
        printf( "%d\t%d\t%d\n" , first[ m ] , second[ m ] , ( is_outlier ? 1 : 0 ) )
    }
}
