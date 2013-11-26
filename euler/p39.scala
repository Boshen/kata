val x = for (p ← 1 to 999;
             a ← 1 to p/4;
             b ← (a+1) to (p-a)/2;
             c = math.sqrt(a*a+b*b)
             if (a+b+c == p)
            ) yield (p)

println( x.groupBy(identity).mapValues(_.size).maxBy(_._2)._1 )
