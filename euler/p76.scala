def count(nums: List[Int], num:Int): Int = nums match {
  case Nil =>
    0
  case head :: tail =>
    if (head > num) 0
    else if (head == num) 1
    else count(nums, num - head) + count(tail, num)
}

println( count((1 to 99).toList, 100) )
