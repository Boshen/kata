/*
 * xy/yz = x/z
 * (10x+y)/(10y+z) = x/z
 * 10xz+yz = 10xy + xz
 * 9xz + yz = 10xy
 * z*(9x + y) = 10xy
 */
def gcd(a: Int, b: Int): Int = if (b == 0) a else gcd(b, a % b)
val fraction =
  (for {
    x <- 1 to 9
    y <- x + 1 to 9
    z <- 1 to 9
    if (z * (9 * x + y) == 10 * x * y)
  } yield (10 * x + y, 10 * y + z)).reduceLeft((n, d) => (n._1 * d._1, n._2 * d._2))

println(fraction._2 / gcd(fraction._1, fraction._2))
