def count(coins: List[Int], coin:Int): Int = coins match {
  case head :: tail => if (head > coin) 0 else if (head == coin) 1 else count(coins, coin - head) + count(tail, coin)
  case _ => 0
}

println( count(List(1, 2, 5, 10, 20, 50, 100, 200), 200) )

