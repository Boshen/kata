def eval(n: Long, c: Int=0): Int = if(n==1) c+1 else eval(if(n%2==0) n/2 else 3*n+1, c+1)
println( Range(1,1000000).iterator.map(x=>(x,eval(x))).maxBy(_._2)._1 )
