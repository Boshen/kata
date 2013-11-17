import scala.annotation.tailrec

def rotations(num: Int): IndexedSeq[Int] = {
  val s = num.toString
  val nums = for (i <- 0 until s.length) yield s.drop(i) + s.take(i)
  nums.map(_.toInt)
}

def isPrime(n: Int) = {
  @tailrec
  def inner(n: Int, k: Int): Boolean = {
    if (k * k > n) true
    else if (n % k != 0) inner(n, k + 2) else false
  }
  assume(n <= Int.MaxValue - 1)
  n > 1 && ((n % 2 != 0) || (n == 2)) && inner(n, 3)
}

println( (1 to 1000000).filter(n => rotations(n).forall(isPrime(_))).length )
