val primes: Stream[Int] = 2 #:: Stream.from(3).filter(i => primes.takeWhile { j => j * j <= i }.forall { i % _ > 0 })
def isPrime(i: Int) = if (i < 2) false else (2 until i).exists(i % _ == 0) == false
def slices(s: String) = (1 until s.length).map(s.take(_).toInt) ++ (1 until s.length).map(s.drop(_).toInt)
println(primes.dropWhile(_ < 23).takeWhile(_ < 1000000).filter(n => slices(n.toString).forall(isPrime(_))).sum)
