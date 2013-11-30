val pentas = (1 to 5000).map(n=>n*(3*n-1)/2).toSet
def isPenta(n: Int) = pentas.contains(n)

val s = for{ i<-pentas
             j<- pentas.dropWhile(_<i)
             if (isPenta(i+j)&&isPenta(j-i))
            } yield j-i

println(s.max)

