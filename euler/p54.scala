val ranks = "23456789TJQKA".zipWithIndex.toMap

def hand(cards: Array[String]) = {

  // get the ranks of each card,
  // find their frequency counts,
  // sort them in the order of frequency then rank
  val groups = cards.map(c => ranks(c(0))).groupBy(identity).mapValues(_.size).toSeq.sortBy(x => (x._2, x._1)).reverse

  // extract the frequencies and their corresponding values
  val values = groups.map(_._1).toList
  val freqs = groups.map(_._2).toList

  val rankList =
    if (values.size == 5) {
      val sameSuit = cards forall (card ⇒ card.last == cards.head.last)
      val isStraight = values.sum == (values.min to values.max).sum
      (sameSuit, isStraight) match {
        case (true, true) ⇒ List.fill(5)(5) // straight flush
        case (true, false) ⇒ List.fill(5)(4) // flush
        case (false, true) ⇒ List.fill(5)(3) // straight
        case (false, false) ⇒ freqs // List(1, 1, 1, 1, 1)
        // royal flush is just straight flush with their corresponding values being 10, J, Q, K, A
      }
    } else
      freqs ++ List.fill(5 - freqs.size)(-1)

  // append -1s so both hands have 10 values,
  // the first 5 values are frequency counts
  // and the next 5 are their corresponding values
  // using -1 as the lowest value (i.e. no value)
  rankList ++ values ++ List.fill(5 - values.size)(-1)
}

def compare(player1: List[Int], player2: List[Int]) =
  (player1, player2).zipped.takeWhile(p => p._1 >= p._2).exists(p => p._1 > p._2)

val pokerHands = io.Source.stdin.getLines.map(_.split(" "))

println(pokerHands.map(x => compare(hand(x.take(5)), hand(x.drop(5)))).count(_ == true))
