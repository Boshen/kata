val matrix = io.Source.stdin.getLines.map(_.split(",").map(_.toInt).toVector).toVector

val pq = scala.collection.mutable.PriorityQueue[(Int, Int, Int)]()(Ordering.by(_._1))

val (rsize, csize) = (matrix.size, matrix(0).size)

val dist = Array.fill(rsize, csize)(Int.MaxValue)

pq.enqueue((matrix(0)(0), 0, 0))

while (!pq.isEmpty) {
  val (sum, row, col) = pq.dequeue()
  for ((r, c) ← List((row + 1, col), (row, col + 1)))
    if (r != rsize && c != csize) {
      val newSum = sum + matrix(r)(c)
      if (newSum < dist(r)(c)) {
        dist(r)(c) = newSum
        pq.enqueue((newSum, r, c))
      }
    }
}

println(dist(rsize - 1)(csize - 1))
