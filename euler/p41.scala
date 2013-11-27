def isPrime(i: Int) = if (i < 2) false else (2 until i).exists(i % _ == 0) == false

println("1234567".permutations.filter(n=>isPrime(n.toInt)).max)
