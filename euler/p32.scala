
println (
  (for {
    i <- 2 to 100
    j <- i to 10000
    mul = i*j
    s = i.toString + j + mul
    if ( s.sorted == "123456789")
  } yield mul).distinct.sum
)
