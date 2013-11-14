val months = Array(31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)

val all = for (y <- 1900 to 2000; m <- 0 until 12) yield
if (m == 1)
  if (y % 4 == 0 && (y % 100 != 0 || y % 400 == 0)) 29 else 28
else
  months(m)

println( all.scanLeft(1)(_+_).drop(12).count(_%7==0))
