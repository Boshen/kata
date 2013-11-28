println((io.Source.stdin.getLines).mkString.split(",").map(_.init.tail).map(s=>s.sum-s.length*64).filter(n=>((math.sqrt(1+8*n)-1)/2).isValidInt).length)
