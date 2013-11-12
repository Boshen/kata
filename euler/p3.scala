var num = 600851475143L
println(Stream.from(2).dropWhile(n => {while(num % n == 0) {num /= n}; num > 1}).head)

