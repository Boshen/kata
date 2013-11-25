println(
  (for (
       i ← 1 until 10000;
       j ← 1 to 9;
       s = (1 to j).map(_*i).mkString;
       if (s.length==9 && s.sorted == "123456789")
       ) yield s).max
)
