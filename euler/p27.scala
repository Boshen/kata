val primes: Stream[Int] = 2 #:: Stream.from(3).filter(i=>primes.takeWhile{j=>j*j<=i}.forall{i%_>0})

def isPrime(n: Int) = primes.takeWhile(_<=n).contains(n)

def countPrimes(a: Int, b: Int) = Stream.from(0).takeWhile(n=>isPrime(n*n+a*n+b)).size

println( (for (a <- -999 until 1000; b <- -999 until 1000) yield (a*b, countPrimes(a,b))).maxBy(_._2)._1 )
