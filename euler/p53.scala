def f(n:Int):BigInt = (2 to n).map(BigInt(_)).product
def C(n: Int, r:Int):BigInt = f(n)/f(r)/f(n-r)
println( (for(n ← 2 to 100; r ← 1 to n) yield C(n,r)).filter(_>=1000000).size )
