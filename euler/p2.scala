def fib: Stream[Long] = {
  def tail(h: Long, n: Long): Stream[Long] = h #:: tail(n, h + n)
  tail(0, 1)
}
println(fib.filter(_ % 2 == 0).takeWhile(_ < 4000000).sum)
