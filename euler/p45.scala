println(Stream.from(40755).map(_.toLong).map(n=>n*(n+1)/2).filter(n=>((1+math.sqrt(1+24*n))/6.0).isValidInt).head)
