/* with n*n grid,
 * top right corner = n*n
 * top left  corner = n*n-n+1
 * bot left  corner = n*n-2*n+2
 * bot right corner = n*n-3*n+3
 * four nums summed = 4*n*n-6*n+6
 */
println( 1 + (3 to 1001 by 2).map(n=>4*n*n-6*n+6).sum )
