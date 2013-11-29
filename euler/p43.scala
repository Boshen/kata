val primes = List(2,3,5,7,11,13,17)

def foo(s: String): Boolean = {
  s.tail.sliding(3).zipWithIndex.map{case(n,i)=>n.toInt%primes(i)==0}.forall(_==true)
}

println("0123456789".permutations.filter(foo).map(_.toLong).sum)
