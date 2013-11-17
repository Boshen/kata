println ( (3 to 100000).filter(x=>x==(x.toString.toList.map(_.asDigit).map(n=>(1 to n).product).sum)).sum )
