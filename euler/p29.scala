println( ((for(a<-2 to 100;b<-2 to 100) yield BigInt(a).pow(b))).distinct.size )
