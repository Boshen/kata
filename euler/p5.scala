def gcd(a: Int, b: Int): Int = if (b == 0) a.abs else gcd(b, a % b)
println(Range(1, 21).foldRight(1)((x, y) => x / gcd(x, y) * y))
