import math.sqrt
val t = Stream.from(1).map(x => ((x+1)*(x/2.0)).toInt)
println((t.find(x=> Range(1,sqrt(x).toInt+1).view.filter(y=>x%y==0).length>250)).get)
