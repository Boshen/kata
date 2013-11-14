println( (io.Source.stdin.getLines).mkString.split(",").map(_.init.tail).sorted.map(_.map(_-64).sum).zipWithIndex.map(x=>x._1*(x._2+1)).sum )
