// The solution is just Pascals triangle
def pascal(row: Int): List[Long] = {
  if (row == 0) List(1L)
  else{
    val p = pascal(row-1)
    1L :: (p,p.tail).zipped.map(_+_) ::: List(1L)
  }
}

// 20*20 grid means 40 rows down the diagonal
println(pascal(40).max)
