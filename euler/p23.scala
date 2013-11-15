val isAbundant = (0 to 28123).map(n => (1 to n/2).filter(n%_==0).sum).zipWithIndex.map(x=>x._1 > x._2).toArray

println( (1 to 28123).filter(i => (12 to i/2).forall(j => !(isAbundant(j) && isAbundant(i-j)))).sum )
