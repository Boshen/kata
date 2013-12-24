def foo(n: Long): Stream[Long] =
  Stream.cons(n, foo(n.toString.map(_.asDigit).map(x=>x*x).sum))
println( (1 to 10000000).view.map(x=>foo(x.toLong).find(x=>x==89 || x==1).get).filter(_==89).size )
