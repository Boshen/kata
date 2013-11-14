val units = Array(0, 3, 3, 5, 4, 4, 3, 5, 5, 4, 3, 6, 6, 8, 8, 7, 7, 9, 8, 8)

val tens = Array(0, 0, 6, 6, 5, 5, 5, 7, 6, 6)

def convert(n: Int): Int = {
  if (n < 20)
    units(n)

  else if (n < 100)
    tens(n / 10) + (if (n % 10 > 0) units(n % 10) else 0)

  else if (n < 1000)
    convert(n / 100) + 7 + (if (n % 100 > 0) 3 + convert(n % 100) else 0)

  else // if (n == 1000)
    11
}

println((1 to 1000).map(convert(_)).sum)
