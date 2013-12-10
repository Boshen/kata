def circular[T](xs: Stream[T]): Stream[T] = {
        lazy val knot: Stream[T] = xs #::: knot
        knot
      }
println(io.Source.stdin.getLines.mkString.split(",").map(_.toInt).zip(circular[Char]("god".toStream)).map{case(c1,c2)=>c1^c2}.sum)
