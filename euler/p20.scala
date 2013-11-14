def fact(n: BigInt): BigInt = if (n == 1) 1 else n * fact(n - 1)
println( fact(100).toString.map(_.asDigit).sum )
