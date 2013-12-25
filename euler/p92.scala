def foo(n: Int): Stream[Int] =
  n #:: foo(n.toString.map(_.asDigit).map(x=>x*x).sum)
println((1 to 10000000).view.map(n=>foo(n).dropWhile(x=>x!=89 && x!=1).head).count(_==89))
