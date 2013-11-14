val ds = (0 until 10000) map {n=>(1 to (n/2)).filter(n%_==0).sum}

println( ds.zipWithIndex.filter{case (n,i)=> n < 10000 && ds(n) != n && ds(n) == i}.foldLeft(0)(_+_._1) )

