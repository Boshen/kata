lazy val fibs: Stream[BigInt] = 0 #:: 1 #:: fibs.zip(fibs.tail).map(p => p._1 + p._2)

println( fibs.takeWhile(_.toString.length < 1000).size )
