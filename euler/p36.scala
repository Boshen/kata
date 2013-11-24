def palindrome(s: String) = s == s.reverse
println((1 to 1000000).filter(s=>palindrome(s.toString) && palindrome(s.toBinaryString)).sum)
