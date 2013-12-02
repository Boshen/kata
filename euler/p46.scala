def isPrime(i: Int) = if (i < 2) false else (2 until i).exists(i % _ == 0) == false
println( Stream.from(3).filter(_%2!=0).dropWhile(n=>Range(0, n).exists(x=>isPrime(n-2*x*x))).head)
