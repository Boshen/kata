/* 5*(9^5) = 295245 >= 99999
   6*(9^5) = 354294 <= 999999 
   so limit to 1000000
 */
println( (2 to 1000000).filter(x => x == (x.toString.map(i=>math.pow(i.asDigit, 5)).sum.toInt )).sum )
